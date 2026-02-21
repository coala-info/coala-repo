cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_morph
label: biobb_morph
doc: "BioExcel Building Blocks morphing tool (Note: The provided text is a container
  execution error log and does not contain the standard help documentation or argument
  definitions).\n\nTool homepage: https://github.com/bioexcel/biobb_morph"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_morph:5.0.1--pyhd7d9b99_0
stdout: biobb_morph.out
