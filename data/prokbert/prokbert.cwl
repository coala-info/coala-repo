cwlVersion: v1.2
class: CommandLineTool
baseCommand: prokbert
label: prokbert
doc: "A tool for genomic language modeling and microbiome analysis (Note: The provided
  text contains system logs and error messages rather than help documentation; therefore,
  no arguments could be extracted).\n\nTool homepage: https://github.com/nbrg-ppcu/prokbert"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/prokbert:0.0.48--pyhdfd78af_0
stdout: prokbert.out
