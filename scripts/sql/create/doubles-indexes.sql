-- Index: double_dirs_lowname_idx

-- DROP INDEX double_dirs_lowname_idx;

CREATE INDEX doubles_lowname_idx
  ON doubles
  USING btree(lowname);

CREATE INDEX doubles_name_idx
  ON doubles
  USING btree(name);