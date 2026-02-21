cwlVersion: v1.2
class: CommandLineTool
baseCommand: sc3-scripts
label: sc3-scripts
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed container build/fetch process for the sc3-scripts
  tool.\n\nTool homepage: https://github.com/ebi-gene-expression-group/bioconductor-sc3-scripts"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sc3-scripts:0.0.6--r351_0
stdout: sc3-scripts.out
