cwlVersion: v1.2
class: CommandLineTool
baseCommand: renet2
label: renet2
doc: "RENET2 (Relation Extraction using Deep Learning). Note: The provided input text
  contains system error messages regarding container image extraction and disk space
  rather than the tool's help documentation.\n\nTool homepage: https://github.com/sujunhao/RENET2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/renet2:1.2--py_0
stdout: renet2.out
