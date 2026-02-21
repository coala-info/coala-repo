cwlVersion: v1.2
class: CommandLineTool
baseCommand: hmnfusion
label: hmnfusion_workflow-hmnfusion
doc: "hmnfusion is a tool for detecting gene fusions from DNA sequencing data.\n\n
  Tool homepage: https://github.com/guillaume-gricourt/HmnFusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hmnfusion:1.5.1--pyh7e72e81_0
stdout: hmnfusion_workflow-hmnfusion.out
