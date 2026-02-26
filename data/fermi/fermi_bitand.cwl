cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fermi
  - bitand
label: fermi_bitand
doc: "Bitwise AND operation on two or more .bit files.\n\nTool homepage: https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_files
    type:
      type: array
      items: File
    doc: Input .bit files
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
stdout: fermi_bitand.out
