cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylip
  - dnadist
label: phylip_dnadist
doc: "Computes distances between sequences.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Input file containing sequences
    inputBinding:
      position: 1
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output file for distances
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
