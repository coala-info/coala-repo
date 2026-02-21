cwlVersion: v1.2
class: CommandLineTool
baseCommand: lotus2
label: lotus3_lotus2
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://lotus3.earlham.ac.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lotus3:3.03--hdfd78af_1
stdout: lotus3_lotus2.out
