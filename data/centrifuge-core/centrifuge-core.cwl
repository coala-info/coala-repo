cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-core
label: centrifuge-core
doc: "The provided text does not contain help information for the tool. It consists
  of system logs indicating a failure to build or extract a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/infphilo/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core.out
