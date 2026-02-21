cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar_twoBitInfo
label: cesar_twoBitInfo
doc: "The provided text does not contain help information for the tool, but rather
  system error logs related to a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar_twoBitInfo.out
