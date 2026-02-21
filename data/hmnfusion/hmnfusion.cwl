cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmnfusion
label: hmnfusion
doc: "The provided text does not contain help documentation for hmnfusion; it contains
  system logs and a fatal error indicating a failure to build the container image
  due to insufficient disk space.\n\nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
stdout: hmnfusion.out
