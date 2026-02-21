cwlVersion: v1.2
class: CommandLineTool
baseCommand: longbow
label: longbow
doc: "A tool for analyzing and processing long-read sequencing data (description not
  available in provided text).\n\nTool homepage: https://github.com/JMencius/longbow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/longbow:2.3.1--py313hdfd78af_0
stdout: longbow.out
