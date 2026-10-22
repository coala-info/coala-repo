cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - get_descendants
label: taxtastic_taxit_get_descendants
doc: "Return given taxids including descendant taxids\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: 'Name of SQL schema in database to query (if database flavor supports this)'
    inputBinding:
      position: 1
      prefix: --schema
  - id: out
    type:
      - 'null'
      - string
    doc: 'Output file'
    inputBinding:
      position: 1
      prefix: --out
  - id: database
    type: File
    doc: 'Taxonomy database (SQLite file made by new_database)'
    inputBinding:
      position: 101
  - id: taxids
    type: string
    doc: 'File or comma delimited list of tax_ids'
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: descendants_file
    type:
      - 'null'
      - File
    doc: 'Tax_ids with their descendants'
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_get_descendants.out
