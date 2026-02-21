cwlVersion: v1.2
class: CommandLineTool
baseCommand: multirnafold
label: multirnafold
doc: "The provided text contains system error messages related to a container build
  failure and does not include help documentation or usage instructions for the tool.\n
  \nTool homepage: http://www.rnasoft.ca/download/README.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/multirnafold:2.1--h9948957_1
stdout: multirnafold.out
