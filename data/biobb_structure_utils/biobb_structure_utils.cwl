cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_structure_utils
label: biobb_structure_utils
doc: "BioExcel Building Blocks (BioBB) structure utilities for manipulating and checking
  molecular structures.\n\nTool homepage: https://github.com/bioexcel/biobb_structure_utils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_structure_utils:5.2.0--pyhdfd78af_0
stdout: biobb_structure_utils.out
