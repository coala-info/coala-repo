cwlVersion: v1.2
class: CommandLineTool
baseCommand: masurca
label: masurca
doc: "The MaSuRCA (Maryland Super-Read Celera Assembler) is a whole-genome assembly
  software.\n\nTool homepage: http://masurca.blogspot.co.uk/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/masurca:4.1.4--h6b3f7d6_0
stdout: masurca.out
