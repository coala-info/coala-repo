cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - get_lineage
label: taxtastic_taxit_get_lineage
doc: "Calculate the taxonomic lineage of tax_ids\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: 'Name of SQL schema in database to query (if database flavor supports this)'
    inputBinding:
      position: 1
      prefix: --schema
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'Output file (stdout if unspecified)'
    inputBinding:
      position: 1
      prefix: --outfile
  - id: database
    type: File
    doc: 'Taxonomy database (SQLite file made by new_database)'
    inputBinding:
      position: 101
  - id: tax_ids
    type:
      type: array
      items: string
    doc: 'One or more tax_ids'
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: lineage_file
    type:
      - 'null'
      - File
    doc: 'Lineages'
    outputBinding:
      glob: $(inputs.outfile)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_get_lineage.out
