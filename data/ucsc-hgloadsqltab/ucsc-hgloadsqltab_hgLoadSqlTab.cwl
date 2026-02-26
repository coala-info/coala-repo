cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgLoadSqlTab
label: ucsc-hgloadsqltab_hgLoadSqlTab
doc: "Load table into database from SQL and text files.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: database
    type: string
    doc: Database name
    inputBinding:
      position: 1
  - id: table
    type: string
    doc: Table name
    inputBinding:
      position: 2
  - id: sql_file
    type: File
    doc: SQL create statement file
    inputBinding:
      position: 3
  - id: tab_files
    type:
      type: array
      items: File
    doc: Tab-separated text files (rows of table)
    inputBinding:
      position: 4
  - id: append
    type:
      - 'null'
      - boolean
    doc: add to existing table
    inputBinding:
      position: 105
      prefix: -append
  - id: not_on_server
    type:
      - 'null'
      - boolean
    doc: file is *not* in a directory that the mysql server can see
    inputBinding:
      position: 105
      prefix: -notOnServer
  - id: old_table
    type:
      - 'null'
      - boolean
    doc: add to existing table
    inputBinding:
      position: 105
      prefix: -oldTable
  - id: warn
    type:
      - 'null'
      - boolean
    doc: warn instead of abort on mysql errors or warnings
    inputBinding:
      position: 105
      prefix: -warn
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgloadsqltab:482--h0b57e2e_0
stdout: ucsc-hgloadsqltab_hgLoadSqlTab.out
