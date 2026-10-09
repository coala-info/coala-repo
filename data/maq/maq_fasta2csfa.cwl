cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - fasta2csfa
label: maq_fasta2csfa
doc: "Convert FASTA to colour-space FASTA\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_fasta2csfa.out
