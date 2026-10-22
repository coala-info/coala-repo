cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - taxids
label: taxtastic_taxit_taxids
doc: "Convert a list of taxonomic names into a recursive list of species level tax_ids\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: 'Name of SQL schema in database to query (if database flavor supports this)'
    inputBinding:
      position: 1
      prefix: --schema
  - id: name_file
    type:
      - 'null'
      - File
    doc: 'File containing a list of taxonomic names, one per line'
    inputBinding:
      position: 1
      prefix: --name-file
  - id: names
    type:
      - 'null'
      - string
    doc: 'List of taxonomic names provided as a comma-delimited list'
    inputBinding:
      position: 1
      prefix: --name
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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: taxids_file
    type:
      - 'null'
      - File
    doc: 'Species level tax_ids'
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_taxids.out
