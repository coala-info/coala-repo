cwlVersion: v1.2
class: CommandLineTool
baseCommand: dcc
label: dcc
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to pull or run the container image due to lack of
  disk space.\n\nTool homepage: https://github.com/dieterich-lab/DCC"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dcc:0.5.0--pyhca03a8a_0
stdout: dcc.out
