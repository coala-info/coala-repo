cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmnfusion_workflow-align
label: hmnfusion_workflow-align
doc: "The provided text does not contain help information for the tool; it is an error
  message regarding container image conversion and disk space.\n\nTool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
stdout: hmnfusion_workflow-align.out
