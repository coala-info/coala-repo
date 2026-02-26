cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phylip
  - dnainvar
label: phylip_dnainvar
doc: "Calculates the number of DNA substitutions between pairs of sequences.\n\nTool
  homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: infile
    type: File
    doc: Input file containing DNA sequences
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
stdout: phylip_dnainvar.out
