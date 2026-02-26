cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylip
  - dolmove
label: phylip_dolmove
doc: "Moves sequences between files.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Input file containing sequences to move.
    inputBinding:
      position: 1
outputs:
  - id: outfile
    type: File
    doc: Output file to which sequences will be moved.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
