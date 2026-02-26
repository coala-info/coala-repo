cwlVersion: v1.2
class: CommandLineTool
baseCommand: java -jar EgaDemoClient.jar
label: ega2
doc: "EGA client for uploading and downloading data.\n\nTool homepage: https://ega-archive.org/download/downloader-quickguide-v2"
inputs:
  - id: password
    type: string
    doc: Password for authentication
    inputBinding:
      position: 101
  - id: username
    type: string
    doc: Username for authentication
    inputBinding:
      position: 101
      prefix: -p
  - id: username_password_commands_file
    type:
      - 'null'
      - File
    doc: File containing username, password, and commands
    inputBinding:
      position: 101
      prefix: -pfs
  - id: username_password_file
    type:
      - 'null'
      - File
    doc: File containing username and password
    inputBinding:
      position: 101
      prefix: -pf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ega2:2.2.2--0
stdout: ega2.out
