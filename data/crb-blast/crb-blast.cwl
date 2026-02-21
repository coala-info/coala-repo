cwlVersion: v1.2
class: CommandLineTool
baseCommand: crb-blast
label: crb-blast
doc: "Conditional Reciprocal Best BLAST\n\nTool homepage: https://github.com/cboursnell/crb-blast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crb-blast:0.6.9--hdfd78af_0
stdout: crb-blast.out
