-- Table: files

-- DROP TABLE files;

CREATE TABLE files
(
  id text NOT NULL, -- Natural key for the file. sha1 checksum for the concatenated fields 'collection', 'path', last_modified', 'size', 'checksum_sha1'.
  collection text NOT NULL, -- Name of the collection this file is part of, for example 'geocities.archiveteam.torrent'.
  path text NOT NULL, -- Path on the local file system, relative from the directory in which all collections are stored.
  last_modified timestamp without time zone NOT NULL, -- The file's last modified timestamp.
  size bigint NOT NULL, -- The file's size in octets.
  checksum_sha1 text NOT NULL, -- The sha1 binary checksum of the file's contents
  agent text NOT NULL, -- The name of the agent responsible for creating this database record.
  "timestamp" timestamp without time zone NOT NULL DEFAULT now() -- Time when this record was created.
)

COMMENT ON TABLE files
  IS 'The following fields represent information about a file that is the absolute truth and trivial to figure out. Each file''s id is derived from these fields.';
COMMENT ON COLUMN files.id IS 'Natural key for the file. sha1 checksum for the concatenated fields ''collection'', ''path'', last_modified'', ''size'', ''checksum_sha1''.';
COMMENT ON COLUMN files.collection IS 'Name of the collection this file is part of, for example ''geocities.archiveteam.torrent''.';
COMMENT ON COLUMN files.path IS 'Path on the local file system, relative from the directory in which all collections are stored.';
COMMENT ON COLUMN files.last_modified IS 'The file''s last modified timestamp.';
COMMENT ON COLUMN files.size IS 'The file''s size in octets.';
COMMENT ON COLUMN files.checksum_sha1 IS 'The sha1 binary checksum of the file''s contents';
COMMENT ON COLUMN files.agent IS 'The name of the agent responsible for creating this database record.';
COMMENT ON COLUMN files."timestamp" IS 'Time when this record was created.';


