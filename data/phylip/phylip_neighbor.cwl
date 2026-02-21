cwlVersion: v1.2
class: CommandLineTool
baseCommand: neighbor
label: phylip_neighbor
doc: "Neighbor-Joining and UPGMA methods (PHYLIP package)\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_neighbor.out
