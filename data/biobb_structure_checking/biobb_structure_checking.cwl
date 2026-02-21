cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_structure_checking
label: biobb_structure_checking
doc: "The provided text does not contain help information or a description of the
  tool. It contains system log messages and a fatal error regarding a container build
  failure (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_structure_checking:3.15.6--pyhdc42f0e_0
stdout: biobb_structure_checking.out
