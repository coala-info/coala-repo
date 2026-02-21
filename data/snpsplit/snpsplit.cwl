cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpsplit
label: snpsplit
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a failed container build/fetch process for the snpsplit
  image.\n\nTool homepage: https://www.bioinformatics.babraham.ac.uk/projects/SNPsplit/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpsplit:0.6.0--hdfd78af_0
stdout: snpsplit.out
