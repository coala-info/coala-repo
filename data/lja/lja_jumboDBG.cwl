cwlVersion: v1.2
class: CommandLineTool
baseCommand: lja_jumboDBG
label: lja_jumboDBG
doc: "The provided text does not contain help information for lja_jumboDBG; it contains
  system error messages regarding a container runtime failure (no space left on device).\n
  \nTool homepage: https://github.com/AntonBankevich/LJA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lja:0.2--h5b5514e_2
stdout: lja_jumboDBG.out
