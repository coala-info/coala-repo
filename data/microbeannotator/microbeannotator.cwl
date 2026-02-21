cwlVersion: v1.2
class: CommandLineTool
baseCommand: microbeannotator
label: microbeannotator
doc: "MicrobeAnnotator is a tool for the comprehensive functional annotation of microbial
  genomes.\n\nTool homepage: https://github.com/cruizperez/MicrobeAnnotator"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/microbeannotator:2.0.5--pyhdfd78af_0
stdout: microbeannotator.out
