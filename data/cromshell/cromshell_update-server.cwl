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
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: config_json
    type:
      - 'null'
      - File
    doc: Updated cromshell config file ($HOME/.cromshell/cromshell_config.json; 
      HOME is the working directory)
    outputBinding:
      glob: .cromshell/cromshell_config.json
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cromshell:2.1.1--pyhdfd78af_0
stdout: cromshell_update-server.out
