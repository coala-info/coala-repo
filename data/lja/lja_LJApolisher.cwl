cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lja
  - LJApolisher
label: lja_LJApolisher
doc: "LJApolisher is a tool within the La Jolla Assembler (LJA) suite, likely used
  for polishing genome assemblies.\n\nTool homepage: https://github.com/AntonBankevich/LJA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lja:0.2--h5b5514e_2
stdout: lja_LJApolisher.out
