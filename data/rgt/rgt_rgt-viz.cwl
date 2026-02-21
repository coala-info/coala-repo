cwlVersion: v1.2
class: CommandLineTool
baseCommand: rgt-viz
label: rgt_rgt-viz
doc: "Regulatory Genomics Toolbox (RGT) visualization tool. Note: The provided text
  contains system logs and error messages regarding a container build failure rather
  than the tool's help documentation; therefore, no arguments could be extracted.\n
  \nTool homepage: http://www.regulatory-genomics.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rgt:1.0.2--py37he4a0461_0
stdout: rgt_rgt-viz.out
