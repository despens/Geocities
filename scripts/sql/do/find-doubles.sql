-- used in 
-- 009-case-insensitivity-dirs.sh
-- 011-case-insensitivity-files.sh

SELECT name 
FROM doubles AS d1 
WHERE 1 < (
	SELECT count(*)
	FROM doubles AS d2
	WHERE d1.lowname = d2.lowname
	)
ORDER BY name DESC;
