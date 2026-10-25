cwlVersion: v1.2
class: CommandLineTool
baseCommand: raSqlQuery
label: ucsc-rasqlquery
doc: "Do a SQL-like query on a RA file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: ra_files
    type:
      - 'null'
      - type: array
        items: File
    doc: One or more RA files to query (not used together with -db)
    inputBinding:
      position: 1
  - id: query
    type:
      - 'null'
      - string
    doc: "SQL-like query, for example: select list,of,fields from file where field='this'"
    inputBinding:
      position: 0
      prefix: -query=
      separate: false
  - id: query_file
    type:
      - 'null'
      - File
    doc: File that holds a query in the same form as the query option
    inputBinding:
      position: 0
      prefix: -queryFile=
      separate: false
  - id: db
    type:
      - 'null'
      - string
    doc: Act on trackDb files for the given database (for example hg19, or all). Sets parent, merge and override.
    inputBinding:
      position: 0
      prefix: -db=
      separate: false
  - id: add_file
    type:
      - 'null'
      - boolean
    doc: Add 'file' field to say where record is defined
    inputBinding:
      position: 0
      prefix: -addFile
  - id: add_db
    type:
      - 'null'
      - boolean
    doc: Add 'db' field to say where record is defined
    inputBinding:
      position: 0
      prefix: -addDb
  - id: strict
    type:
      - 'null'
      - boolean
    doc: Used only with db option. Only report tracks that exist in db
    inputBinding:
      position: 0
      prefix: -strict
  - id: key
    type:
      - 'null'
      - string
    doc: Use this field as the key field for merges and parenting (default name)
    inputBinding:
      position: 0
      prefix: -key=
      separate: false
  - id: parent
    type:
      - 'null'
      - boolean
    doc: Merge together inheriting on parentField
    inputBinding:
      position: 0
      prefix: -parent
  - id: parent_field
    type:
      - 'null'
      - string
    doc: Use this field as the one that tells us who is our parent (default subTrack)
    inputBinding:
      position: 0
      prefix: -parentField=
      separate: false
  - id: override_needed
    type:
      - 'null'
      - boolean
    doc: Records are only overridden field-by-field by later records if 'override' follows the track name
    inputBinding:
      position: 0
      prefix: -overrideNeeded
  - id: no_inherit_field
    type:
      - 'null'
      - string
    doc: If this field is present do not inherit fields from parent
    inputBinding:
      position: 0
      prefix: -noInheritField=
      separate: false
  - id: merge
    type:
      - 'null'
      - boolean
    doc: Records with the same keyField in multiple raFiles are merged, later files overriding earlier ones
    inputBinding:
      position: 0
      prefix: -merge
  - id: restrict
    type:
      - 'null'
      - File
    doc: Restrict output to only records with keys listed in this file
    inputBinding:
      position: 0
      prefix: -restrict=
      separate: false
outputs:
  - id: output
    type: stdout
    doc: Query result
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rasqlquery:482--h0b57e2e_0
stdout: ucsc-rasqlquery.out
