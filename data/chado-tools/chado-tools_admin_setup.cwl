cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - admin
  - setup
label: chado-tools_admin_setup
doc: "set up a blank CHADO database according to a given schema\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "verbose mode"
    inputBinding:
      position: 101
      prefix: --verbose
  - id: config
    type:
      - 'null'
      - File
    doc: "YAML file containing connection details"
    inputBinding:
      position: 101
      prefix: --config
  - id: use_password
    type:
      - 'null'
      - boolean
    doc: "connect with password (default: no password)"
    inputBinding:
      position: 101
      prefix: --use_password
  - id: dbname
    type: string
    doc: "name of the database"
    inputBinding:
      position: 1
  - id: schema
    type:
      - 'null'
      - string
    doc: "Database schema (default: GMOD schema 1.31) (choices: gmod, basic, audit, audit_backup) [default: gmod]"
    inputBinding:
      position: 101
      prefix: --schema
  - id: schema_file
    type:
      - 'null'
      - File
    doc: "File with database schema"
    inputBinding:
      position: 101
      prefix: --schema_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
stdout: chado-tools_admin_setup.out
