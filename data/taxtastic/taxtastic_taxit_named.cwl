cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - named
label: taxtastic_taxit_named
doc: "Filter unclassified, unnamed taxonomy ids\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: 'Name of SQL schema in database to query (if database flavor supports this)'
    inputBinding:
      position: 1
      prefix: --schema
  - id: tax_ids
    type:
      - 'null'
      - type: array
        items: string
    doc: 'One or more tax_ids'
    inputBinding:
      position: 1
      prefix: --tax-ids
  - id: tax_id_file
    type:
      - 'null'
      - File
    doc: 'File containing a whitespace-delimited list of tax_ids'
    inputBinding:
      position: 1
      prefix: --tax-id-file
  - id: seq_info
    type:
      - 'null'
      - File
    doc: 'Sequence info file, minimally containing a column named tax_id'
    inputBinding:
      position: 1
      prefix: --seq-info
  - id: ranked
    type:
      - 'null'
      - boolean
    doc: 'Ignore ''no rank'' taxonomies'
    inputBinding:
      position: 1
      prefix: --ranked
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'Output file containing named taxonomy ids (stdout if unspecified)'
    inputBinding:
      position: 1
      prefix: --outfile
  - id: database
    type: File
    doc: 'Taxonomy database (SQLite file made by new_database); placed before the options because tax_ids takes several values'
    inputBinding:
      position: 0
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: named_file
    type:
      - 'null'
      - File
    doc: 'Named taxonomy ids'
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_named.out
