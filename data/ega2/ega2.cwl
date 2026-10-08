cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - ega2
label: ega2
doc: "EGA client for uploading and downloading data. Runs the command line shell
  with a username and password, or reads them (and optionally all commands) from
  a file.\n\nTool homepage: https://ega-archive.org/download/downloader-quickguide-v2"
inputs:
  - id: username
    type:
      - 'null'
      - string
    doc: Username for authentication
    inputBinding:
      position: 1
      prefix: -p
  - id: password
    type:
      - 'null'
      - string
    doc: Password for authentication (given after the username)
    inputBinding:
      position: 2
  - id: username_password_file
    type:
      - 'null'
      - File
    doc: File containing username and password
    inputBinding:
      position: 3
      prefix: -pf
  - id: username_password_commands_file
    type:
      - 'null'
      - File
    doc: File containing username, password, and commands
    inputBinding:
      position: 3
      prefix: -pfs
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ega2:2.2.2--0
stdout: ega2.out
