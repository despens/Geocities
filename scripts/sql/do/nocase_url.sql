-- used by proxy.py

SELECT 
    url
FROM
    urls

WHERE lower(urls.url) = lower(%(url)s)
