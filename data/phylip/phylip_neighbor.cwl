cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylip
  - neighbor
label: phylip_neighbor
doc: "Neighbor-joining method for constructing phylogenetic trees.\n\nTool homepage:
  http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Input file containing the distance matrix or sequence data.
    inputBinding:
      position: 1
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file for the phylogenetic tree.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
