cwlVersion: v1.2
class: CommandLineTool
baseCommand: gplas
label: gplas
doc: "gplas: a tool for binning plasmid-predicted contigs into discrete plasmid units.\n
  \nTool homepage: https://gitlab.com/sirarredondo/gplas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gplas:0.6.1--hdfd78af_1
stdout: gplas.out
