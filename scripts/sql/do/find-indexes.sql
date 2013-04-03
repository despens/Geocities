-- used by 013-indexes.sh

select id, checksum_sha1, path
from files
where   
    lower(path) like '%/index.htm'
    or 
    lower(path) like '%/index.html'
order by path
;