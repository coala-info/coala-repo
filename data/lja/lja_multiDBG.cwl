cwlVersion: v1.2
class: CommandLineTool
baseCommand: lja_multiDBG
label: lja_multiDBG
doc: "La Jolla Assembler multiDBG (Note: The provided text is a container runtime
  error log and does not contain CLI help information or argument definitions).\n\n
  Tool homepage: https://github.com/AntonBankevich/LJA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lja:0.2--h5b5514e_2
stdout: lja_multiDBG.out
