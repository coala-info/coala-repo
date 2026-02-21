cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabob
label: rnabob
doc: "A program for fast searching of RNA secondary structure motifs in sequence databases.\n
  \nTool homepage: https://github.com/JPSieg/KertisThesis2021"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabob:2.2.1--h470a237_1
stdout: rnabob.out
