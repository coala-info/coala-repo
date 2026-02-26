cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgTrackDb
label: ucsc-hgtrackdb_hgTrackDb
doc: "Create trackDb table from text files.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: org
    type: Directory
    doc: "a directory name with a hierarchy of trackDb.ra files to examine\n     \
      \ - in the case of a single directory with a single trackDb.ra file use ."
    inputBinding:
      position: 1
  - id: database
    type: string
    doc: name of database to create the trackDb table in
    inputBinding:
      position: 2
  - id: trackDb_table_name
    type: string
    doc: name of table to create, usually trackDb, or trackDb_${USER}
    inputBinding:
      position: 3
  - id: trackDb_sql_file
    type: File
    doc: "SQL definition of the table to create, typically from\n               -
      the source tree file: src/hg/lib/trackDb.sql\n               - the table name
      in the CREATE statement is replaced by the\n               - table name specified
      on this command line."
    inputBinding:
      position: 4
  - id: hg_root
    type: Directory
    doc: "a directory name to prepend to org to locate the hierarchy:\n          \
      \ hgRoot/trackDb.ra - top level trackDb.ra file processed first\n          \
      \ hgRoot/org/trackDb.ra - second level file processed second\n           hgRoot/org/database/trackDb.ra
      - third level file processed last\n         - for no directory hierarchy use
      ."
    inputBinding:
      position: 5
  - id: add_version
    type:
      - 'null'
      - boolean
    doc: add cartVersion pseudo-table
    inputBinding:
      position: 106
      prefix: -addVersion
  - id: gbdb_list
    type:
      - 'null'
      - string
    doc: list of files to confirm existance of bigDataUrl files
    inputBinding:
      position: 106
      prefix: -gbdbList
  - id: no_html_check
    type:
      - 'null'
      - boolean
    doc: don't check for HTML even if strict is set
    inputBinding:
      position: 106
      prefix: -noHtmlCheck
  - id: ra_name
    type:
      - 'null'
      - string
    doc: "Specify a file name to use other than trackDb.ra\n   for the ra files."
    inputBinding:
      position: 106
      prefix: -raName
  - id: release
    type:
      - 'null'
      - string
    doc: Include trackDb entries with this release tag only.
    inputBinding:
      position: 106
      prefix: -release
  - id: settings
    type:
      - 'null'
      - boolean
    doc: "for trackDb scanning, output table name, type line,\n            -  and
      settings hash to stderr while loading everything."
    inputBinding:
      position: 106
      prefix: -settings
  - id: strict
    type:
      - 'null'
      - boolean
    doc: only include tables that exist (and complain about missing html files).
    inputBinding:
      position: 106
      prefix: -strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgtrackdb:482--h0b57e2e_0
stdout: ucsc-hgtrackdb_hgTrackDb.out
