-- Table: urls

-- DROP TABLE urls;

CREATE TABLE urls
(
  id text NOT NULL, -- Natural key of a URL mapping. sha1 checksum of concatenated fields 'url', 'file_id', 'agent'
  url text NOT NULL, -- Full historic URL.
  file_id text NOT NULL, -- id of the file the URL points to.
  agent text NOT NULL, -- Name of the agent that created this record.
  "timestamp" timestamp without time zone DEFAULT now() -- Time when this entry was created.
)

COMMENT ON TABLE urls
  IS 'Mappings of URLs to files';
COMMENT ON COLUMN urls.id IS 'Natural key of a URL mapping. sha1 checksum of concatenated fields ''url'', ''file_id'', ''agent''';
COMMENT ON COLUMN urls.url IS 'Full historic URL.';
COMMENT ON COLUMN urls.file_id IS 'id of the file the URL points to.';
COMMENT ON COLUMN urls.agent IS 'Name of the agent that created this record.';
COMMENT ON COLUMN urls."timestamp" IS 'Time when this entry was created.';


