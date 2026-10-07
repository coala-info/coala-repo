cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chado
  - admin
  - drop
label: chado-tools_admin_drop
doc: "drop a CHADO database (the confirmation prompt is answered with y)\n\nTool homepage: https://github.com/sanger-pathogens/chado-tools/"
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
  - id: confirmation
    type: File
    doc: answer to the confirmation prompt (default is a file containing "y")
    default:
      class: File
      basename: confirm_drop.txt
      contents: "y\n"
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
stdin: $(inputs.confirmation.path)
stdout: chado-tools_admin_drop.out
