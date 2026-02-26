cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylip
  - dnapars
label: phylip_dnapars
doc: "Parses DNA sequences for phylogenetic analysis.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Input file containing DNA sequences.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnapars.out
