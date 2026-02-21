cwlVersion: v1.2
class: CommandLineTool
baseCommand: packmol
label: packmol
doc: "Packing optimization for the automated generation of starting configurations
  for molecular dynamics simulations.\n\nTool homepage: https://github.com/m3g/packmol"
inputs:
  - id: input_file
    type: File
    doc: Input file containing packing instructions (provided via standard input redirection)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/packmol:18.169
stdout: packmol.out
