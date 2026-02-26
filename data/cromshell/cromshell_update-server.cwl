cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cromshell
  - update-server
label: cromshell_update-server
doc: "Update the cromwell server in the following config file /root/.cromshell/cromshell_config.json\n\
  \nTool homepage: https://github.com/broadinstitute/cromshell"
inputs:
  - id: cromwell_server_url
    type: string
    doc: Cromwell server URL
    inputBinding:
      position: 1
  - id: config_file
    type:
      - 'null'
      - File
    doc: Path to the cromshell config file
    inputBinding:
      position: 102
      prefix: --config-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_update-server.out
