cwlVersion: v1.2
class: CommandLineTool
baseCommand: agfusion
label: agfusion
doc: "AGFusion is a tool for visualizing and annotating gene fusions. (Note: The provided
  text appears to be a system error log regarding a container build failure and does
  not contain help text or argument definitions.)\n\nTool homepage: https://github.com/murphycj/AGFusion"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/agfusion:1.252--py_0
stdout: agfusion.out
