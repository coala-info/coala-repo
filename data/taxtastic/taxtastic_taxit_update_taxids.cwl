cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - update_taxids
label: taxtastic_taxit_update_taxids
doc: "Replace obsolete tax_ids using the merged table of the taxonomy database\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: schema
    type:
      - 'null'
      - string
    doc: 'Name of SQL schema in database to query (if database flavor supports this)'
    inputBinding:
      position: 1
      prefix: --schema
  - id: delimiter
    type:
      - 'null'
      - string
    doc: 'Infile columns delimiter (default: ,)'
    inputBinding:
      position: 1
      prefix: --delimiter
  - id: taxid_column
    type:
      - 'null'
      - string
    doc: 'Name of column or index if headerless containing tax_ids to be replaced (default: tax_id)'
    inputBinding:
      position: 1
      prefix: --taxid-column
  - id: unknowns
    type:
      - 'null'
      - string
    doc: 'Output file containing rows with unknown tax_ids having no replacements in merged table'
    inputBinding:
      position: 1
      prefix: --unknowns
  - id: unknown_action
    type:
      - 'null'
      - string
    doc: 'Action for tax_ids with no replacement in merged table: drop, ignore or error (default: error)'
    inputBinding:
      position: 1
      prefix: --unknown-action
  - id: outfile
    type:
      - 'null'
      - string
    doc: 'Modified version of the input file (default: stdout)'
    inputBinding:
      position: 1
      prefix: --outfile
  - id: infile
    type: File
    doc: 'Input file with taxids (sequence info file as passed to taxit create --seq-info)'
    inputBinding:
      position: 101
  - id: database
    type: File
    doc: 'Taxonomy database (SQLite file made by new_database)'
    inputBinding:
      position: 102
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: updated_file
    type:
      - 'null'
      - File
    doc: 'Input file with updated tax_ids'
    outputBinding:
      glob: $(inputs.outfile)
  - id: unknowns_file
    type:
      - 'null'
      - File
    doc: 'Rows with unknown tax_ids'
    outputBinding:
      glob: $(inputs.unknowns)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_update_taxids.out
