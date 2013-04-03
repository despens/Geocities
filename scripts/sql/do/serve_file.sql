-- Used by proxy.py 

SELECT 
    files.path,
    files.last_modified,
    files.size,
    files.checksum_sha1,
    urls.url,

    (SELECT props.obj
       FROM props
      WHERE props.file_id = files.id
        AND props.rel = 'HTTP Content-Type') AS content_type,

    (SELECT props.obj
       FROM props
      WHERE props.file_id = files.id
        AND props.rel = 'HTTP charset') AS charset
    
FROM
    files, urls

WHERE urls.url = %(url)s
  AND urls.file_id = files.id;