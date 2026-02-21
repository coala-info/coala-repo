cwlVersion: v1.2
class: CommandLineTool
baseCommand: lja
label: lja
doc: "The provided text does not contain help information for the tool 'lja'. It contains
  system log messages and a fatal error regarding container image conversion and disk
  space.\n\nTool homepage: https://github.com/AntonBankevich/LJA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lja:0.2--h5b5514e_2
stdout: lja.out
