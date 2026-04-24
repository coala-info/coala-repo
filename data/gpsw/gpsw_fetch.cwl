cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpsw_fetch
label: gpsw_fetch
doc: "Fetch GPSW code from a specific release from https://github.com/niekwit/gps-orfeome.\n\
  \nTool homepage: https://github.com/niekwit/gps-orfeome"
inputs:
  - id: directory
    type:
      - 'null'
      - Directory
    doc: Directory to download the code to target directory
    inputBinding:
      position: 101
      prefix: --directory
  - id: tag
    type:
      - 'null'
      - string
    doc: Release tag of the code to download
    inputBinding:
      position: 101
      prefix: --tag
  - id: test_data
    type:
      - 'null'
      - boolean
    doc: Include test data in the download (and relating config and resources 
      directories)
    inputBinding:
      position: 101
      prefix: --test-data
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
stdout: gpsw_fetch.out
