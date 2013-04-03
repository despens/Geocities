Every database table is split into two files,
one containing the fields, another containing the
constraints and indexes. 

    <tablename>.sql
    <tablename>[-constraints]-indexes.sql

This allows to temporarily disable the db's integrity
checking and sorting optimization -- and to speed up 
large inserting operations.

If you're not sure what this means, please execute
both files for each table and don't worry about it.
If you know what it means, be careful not to mess
things up. :)