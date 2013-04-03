-- Table: props

-- DROP TABLE props;

CREATE TABLE props
(
  id text NOT NULL, -- sha1 checksum of concatenated fields 'file_id', 'rel', 'obj', 'agent'
  file_id text, -- id of the file this property belongs to.
  rel text, -- Type of relation
  obj text, -- Object the file is related to.
  agent text, -- Name of the agent responsible for this entry
  "timestamp" timestamp without time zone DEFAULT now() -- Time when this entry was created
)

COMMENT ON TABLE props
  IS 'Properties of files that require content analysis or human judgement.';
COMMENT ON COLUMN props.id IS 'sha1 checksum of concatenated fields ''file_id'', ''rel'', ''obj'', ''agent''';
COMMENT ON COLUMN props.file_id IS 'id of the file this property belongs to.';
COMMENT ON COLUMN props.rel IS 'Type of relation';
COMMENT ON COLUMN props.obj IS 'Object the file is related to.';
COMMENT ON COLUMN props.agent IS 'Name of the agent responsible for this entry';
COMMENT ON COLUMN props."timestamp" IS 'Time when this entry was created';


