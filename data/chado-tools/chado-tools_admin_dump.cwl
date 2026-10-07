cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - admin
  - dump
label: chado-tools_admin_dump
doc: "dump a CHADO database into an archive file\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
  - id: archive
    type: string
    doc: "archive file to be created"
    inputBinding:
      position: 2
outputs:
  - id: archive_file
    type: File
    doc: database archive file
    outputBinding:
      glob: $(inputs.archive)
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/chado-tools:0.2.15--py_0
