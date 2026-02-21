cwlVersion: v1.2
class: CommandLineTool
baseCommand: lotus3
label: lotus3
doc: "The provided text is an error log regarding a container build failure and does
  not contain help information or usage instructions for the lotus3 tool.\n\nTool
  homepage: https://lotus3.earlham.ac.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lotus3:3.03--hdfd78af_1
stdout: lotus3.out
