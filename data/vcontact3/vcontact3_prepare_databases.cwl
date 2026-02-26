cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - vcontact3
  - prepare_databases
label: vcontact3_prepare_databases
doc: "Prepare vContact2 databases\n\nTool homepage: https://bitbucket.org/MAVERICLab/vcontact3"
inputs:
  - id: available_dbs
    type:
      - 'null'
      - File
    doc: Path to a JSON file listing available database versions and their 
      download URLs. Defaults to ~/.vcontact/available_dbs.json
    inputBinding:
      position: 101
      prefix: --available-dbs
  - id: download_path
    type:
      - 'null'
      - Directory
    doc: Path to download databases to. Defaults to ~/.vcontact/databases
    inputBinding:
      position: 101
      prefix: --download-path
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vcontact3:3.1.6--pyhdfd78af_0
stdout: vcontact3_prepare_databases.out
