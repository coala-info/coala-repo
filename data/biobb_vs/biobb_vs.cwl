cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_vs
label: biobb_vs
doc: "BioExcel Building Blocks for Virtual Screening (Note: The provided help text
  contains only system error logs and no usage information.)\n\nTool homepage: https://github.com/bioexcel/biobb_vs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_vs:5.2.0--pyhdfd78af_0
stdout: biobb_vs.out
