cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - taxit
  - new_database
label: taxtastic_taxit_new_database
doc: "Download NCBI taxonomy and create a database (SQLite file)\n\nTool homepage: https://github.com/fhcrc/taxtastic"
inputs:
  - id: database_name
    type:
      - 'null'
      - string
    doc: 'Name of the SQLite database file to create (default: ncbi_taxonomy.db)'
    inputBinding:
      position: 101
  - id: no_clobber
    type:
      - 'null'
      - boolean
    doc: 'If database exists keep current data and append new data'
    inputBinding:
      position: 1
      prefix: --no-clobber
  - id: no_load
    type:
      - 'null'
      - boolean
    doc: 'Create schema and exit'
    inputBinding:
      position: 1
      prefix: --no-load
  - id: unknown_action
    type:
      - 'null'
      - string
    doc: 'Action to perform for unknown ranks: error or warn (default: error)'
    inputBinding:
      position: 1
      prefix: --unknown-action
  - id: out
    type:
      - 'null'
      - string
    doc: 'Table sql'
    inputBinding:
      position: 1
      prefix: --out
  - id: schema
    type:
      - 'null'
      - string
    doc: 'Name of SQL schema in database to query (if database flavor supports this)'
    inputBinding:
      position: 1
      prefix: --schema
  - id: taxdump_file
    type:
      - 'null'
      - File
    doc: 'Location of zipped taxdump file (default: taxdmp.zip, downloaded when missing)'
    inputBinding:
      position: 1
      prefix: --taxdump-file
  - id: taxdump_url
    type:
      - 'null'
      - string
    doc: 'Url to taxdump file (default: https://ftp.ncbi.nlm.nih.gov/pub/taxonomy/taxdmp.zip)'
    inputBinding:
      position: 1
      prefix: --taxdump-url
  - id: download_dir
    type:
      - 'null'
      - string
    doc: 'Name of the directory into which to download the zip archive (default: the directory of the database file)'
    inputBinding:
      position: 1
      prefix: --download-dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_file
    type:
      - 'null'
      - File
    doc: 'SQLite taxonomy database'
    outputBinding:
      glob: $(inputs.database_name || 'ncbi_taxonomy.db')
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/taxtastic:0.12.0--pyhdfd78af_0
stdout: taxtastic_taxit_new_database.out
