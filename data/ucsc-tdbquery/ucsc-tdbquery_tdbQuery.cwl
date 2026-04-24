cwlVersion: v1.2
class: CommandLineTool
baseCommand: tdbQuery
label: ucsc-tdbquery_tdbQuery
doc: "Query the trackDb system using SQL syntax.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: sql_statement
    type: string
    doc: SQL statement enclosed in quotations
    inputBinding:
      position: 1
  - id: check
    type:
      - 'null'
      - boolean
    doc: Check that trackDb is internally consistent. Prints diagnostic output 
      to stderr and aborts if there's problems.
    inputBinding:
      position: 102
      prefix: -check
  - id: long_label_length
    type:
      - 'null'
      - int
    doc: Complain if longLabels are over N characters
    inputBinding:
      position: 102
      prefix: -longLabelLength
  - id: no_blank
    type:
      - 'null'
      - boolean
    doc: Don't print out blank lines separating records
    inputBinding:
      position: 102
      prefix: -noBlank
  - id: no_comp_sub
    type:
      - 'null'
      - boolean
    doc: Subtracks don't inherit fields from parents
    inputBinding:
      position: 102
      prefix: -noCompSub
  - id: one_line
    type:
      - 'null'
      - boolean
    doc: Print single ('|') pipe-separated line per record
    inputBinding:
      position: 102
      prefix: -oneLine
  - id: release
    type:
      - 'null'
      - string
    doc: Include trackDb entries with this release tag only.
    inputBinding:
      position: 102
      prefix: -release
  - id: root_dir
    type:
      - 'null'
      - Directory
    doc: Sets the root directory of the trackDb.ra directory hierarchy
    inputBinding:
      position: 102
      prefix: -root
  - id: short_label_length
    type:
      - 'null'
      - int
    doc: Complain if shortLabels are over N characters
    inputBinding:
      position: 102
      prefix: -shortLabelLength
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Mimic -strict option on hgTrackDb. Suppresses tracks where 
      corresponding table does not exist.
    inputBinding:
      position: 102
      prefix: -strict
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tdbquery:482--h0b57e2e_0
stdout: ucsc-tdbquery_tdbQuery.out
