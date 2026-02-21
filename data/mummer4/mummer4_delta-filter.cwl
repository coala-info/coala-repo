cwlVersion: v1.2
class: CommandLineTool
baseCommand: delta-filter
label: mummer4_delta-filter
doc: "The provided text does not contain help information for the tool. It is an error
  log indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://mummer4.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mummer4:4.0.1--pl5321h9948957_0
stdout: mummer4_delta-filter.out
