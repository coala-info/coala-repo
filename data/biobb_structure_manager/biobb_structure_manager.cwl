cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_structure_manager
label: biobb_structure_manager
doc: "The provided text does not contain help information; it is a system error log
  indicating a failure to build or extract the container image due to lack of disk
  space. No arguments or tool descriptions could be extracted from the input.\n\n
  Tool homepage: https://github.com/bioexcel/biobb_analysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_structure_manager:3.0.2--py_0
stdout: biobb_structure_manager.out
