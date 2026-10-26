cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcontact3
  - prepare_databases
label: vcontact3_prepare_databases
doc: "Download and prepare the vConTACT3 reference databases.\n\nTool homepage: https://bitbucket.org/MAVERICLab/vcontact3"
inputs:
  - id: list_versions
    type:
      - 'null'
      - boolean
    doc: View available database versions and exit.
    inputBinding:
      position: 101
      prefix: --list-versions
  - id: get_version
    type:
      - 'null'
      - string
    doc: Download specified database version (default latest).
    inputBinding:
      position: 101
      prefix: --get-version
  - id: download_location
    type:
      - 'null'
      - string
    doc: Download path (default is the current directory).
    inputBinding:
      position: 101
      prefix: --set-location
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: database_dir
    type:
      - 'null'
      - Directory
    doc: Directory the database was downloaded to
    outputBinding:
      glob: $(inputs.download_location)
requirements:
  - class: InlineJavascriptRequirement
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
stdout: vcontact3_prepare_databases.out
