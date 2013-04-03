import sys, os, urlparse, json, datetime
from twisted.internet import reactor, endpoints
from twisted.python import log
from twisted.web import http, proxy
import psycopg2 as dbapi2
import psycopg2.extras # for dictionary query resluts!

db = dbapi2.connect(database=os.environ['GEO_DB_DB'], user=os.environ['GEO_DB_USER'], password=os.environ['GEO_DB_PASSWD'])
db.autocommit = True # so that all the SELECTs are not trapped inside a transaction
cur = db.cursor(cursor_factory=psycopg2.extras.DictCursor)

Queries = {
    'serve_file': open(os.environ['GEO_SCRIPTS']+'/sql/do/serve_file.sql','r').read(),
    'nocase_url': open(os.environ['GEO_SCRIPTS']+'/sql/do/nocase_url.sql','r').read()
}

mirrored_hosts = json.loads( open(os.environ['GEO_SCRIPTS']+'/setup/hosts.json', 'r').read() )



def GEOserve(response, headers):
    
    # construct the database search url from request headers
    url = headers['host'] + headers['path']
    # cut away the search portion, at the "?"
    question_mark = url.find('?')
    if question_mark > -1:
        url = url[:question_mark]


    # 1. ask database for info on the original
    # request url
    cur.execute(Queries['serve_file'], {'url':url})
    if cur.rowcount > 0:
        result = cur.fetchone()

        # load the file to be served
        file_data = open( os.environ['GEO_ARCHIVE'] + '/' + result['path'], 'rb' ).read()
        response.setResponseCode(200, "OK")

        # # cheesy popup-blocker
        # if result['content_type'] == 'text/html':
        #     file_data = file_data.replace('open(', 'WWWW(')


        # construct content type
        charset = ''
        if result['charset']:
            charset = ';charset=' + result['charset']
        response.responseHeaders.addRawHeader('Content-Type', result['content_type']+charset)

        # calculate epoch time and set last-modified
        last_modified = (result['last_modified']-datetime.datetime(1970,1,1)).total_seconds()
        response.setLastModified(last_modified)

        response.responseHeaders.addRawHeader('Content-Length', result['size'])
        
        # pump out the file!
        response.write(file_data);
        response.finish()

        return True
    
    # 2. if there is no result, try with an appended slash
    if cur.rowcount == 0:
        cur.execute(Queries['serve_file'], {'url': url+'/'})
        # if found, redirect to new URL
        if cur.rowcount > 0:
            result = cur.fetchone()
            response.redirect('http://'+result['url'])
            response.finish()
            return True

    # 3. try the same thing with lower case letters
    if cur.rowcount == 0:
        cur.execute(Queries['nocase_url'], {'url': url})
        # if found, redirect to new URL
        if cur.rowcount > 0:
            result = cur.fetchone()
            response.redirect('http://'+result['url'])
            response.finish()
            return True

    # 4. try lowercase and a slash
    if cur.rowcount == 0:
        cur.execute(Queries['nocase_url'], {'url': url+'/'})
        # if found, redirect to new URL
        if cur.rowcount > 0:
            result = cur.fetchone()
            response.redirect('http://'+result['url'])
            response.finish()
            return True


    
    return False




class ProxyRequest(proxy.ProxyRequest):
    #protocols = dict(http=ProxyClientFactory)

    def process(self):
        parsed = urlparse.urlparse(self.uri)
        protocol = parsed[0]
        host = parsed[1]
        port = self.ports[protocol]
        if ':' in host:
            host, port = host.split(':')
            port = int(port)

        rest = urlparse.urlunparse(('', '') + parsed[2:])
        if not rest:
            rest = rest + '/'
        class_ = self.protocols[protocol]


        headers = self.getAllHeaders().copy()
        if 'host' not in headers:
            headers['host'] = host
        self.content.seek(0, 0)
        s = self.content.read()

        headers['path'] = rest

        if headers['host'] == "geocities.com":
            host = "www.geocities.com"
            headers['host'] = "www.geocities.com"

        if host in mirrored_hosts:
            found = GEOserve(self, headers)
            if found:
                return True

        if host == 'research.geocities.com':
            host = 'localhost'
            port = 8090

        clientFactory = class_(self.method, rest, self.clientproto, headers, s, self)
        self.reactor.connectTCP(host, port, clientFactory)



class Proxy(proxy.Proxy):
    requestFactory = ProxyRequest

class ProxyFactory(http.HTTPFactory):
    protocol = Proxy

log.startLogging(sys.stdout)
endpoint = endpoints.serverFromString(reactor, 'tcp:8080')
d = endpoint.listen(ProxyFactory())
reactor.run()