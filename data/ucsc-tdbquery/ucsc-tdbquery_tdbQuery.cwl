cwlVersion: v1.2
class: CommandLineTool
baseCommand: tdbQuery
label: ucsc-tdbquery_tdbQuery
doc: "Query the trackDb system using SQL syntax. Only a restricted subset of a single select statement is supported.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: sql_statement
    type: string
    doc: SQL statement, for example "select count(*) from hg18"
    inputBinding:
      position: 2
  - id: root_dir
    type:
      - 'null'
      - Directory
    doc: Sets the root directory of the trackDb.ra directory hierarchy
    inputBinding:
      position: 1
      prefix: -root=
      separate: false
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check that trackDb is internally consistent. Prints diagnostic output to stderr and aborts if there are problems.
    inputBinding:
      position: 1
      prefix: -check
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Mimic -strict option on hgTrackDb. Suppresses tracks where corresponding table does not exist.
    inputBinding:
      position: 1
      prefix: -strict
  - id: release
    type:
      - 'null'
      - string
    doc: Include trackDb entries with this release tag only (alpha, beta or public).
    inputBinding:
      position: 1
      prefix: -release=
      separate: false
  - id: no_blank
    type:
      - 'null'
      - boolean
    doc: Do not print out blank lines separating records
    inputBinding:
      position: 1
      prefix: -noBlank
  - id: one_line
    type:
      - 'null'
      - boolean
    doc: Print single ('|') pipe-separated line per record
    inputBinding:
      position: 1
      prefix: -oneLine
  - id: no_comp_sub
    type:
      - 'null'
      - boolean
    doc: Subtracks do not inherit fields from parents
    inputBinding:
      position: 1
      prefix: -noCompSub
  - id: short_label_length
    type:
      - 'null'
      - int
    doc: Complain if shortLabels are over N characters
    inputBinding:
      position: 1
      prefix: -shortLabelLength=
      separate: false
  - id: long_label_length
    type:
      - 'null'
      - int
    doc: Complain if longLabels are over N characters
    inputBinding:
      position: 1
      prefix: -longLabelLength=
      separate: false
outputs:
  - id: output
    type: stdout
    doc: Query result
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tdbquery:482--h0b57e2e_0
stdout: ucsc-tdbquery_tdbQuery.out
