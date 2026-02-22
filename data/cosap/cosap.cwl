cwlVersion: v1.2
class: CommandLineTool
baseCommand: cosap
label: cosap
doc: "The provided text appears to be an error log from a container build process
  rather than help text for the 'cosap' tool. As a result, no command-line arguments
  could be extracted.\n\nTool homepage: https://github.com/MBaysanLab/cosap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cosap:0.1.0--pyh026a95a_0
stdout: cosap.out
