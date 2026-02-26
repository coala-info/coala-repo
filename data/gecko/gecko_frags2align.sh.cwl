cwlVersion: v1.2
class: CommandLineTool
baseCommand: gecko_frags2align.sh
label: gecko_frags2align.sh
doc: "Converts fragment files to alignment files.\n\nTool homepage: https://github.com/otorreno/gecko"
inputs:
  - id: frags_file
    type: File
    doc: Input fragment file (.frags/.csv)
    inputBinding:
      position: 1
  - id: fasta_x
    type: File
    doc: First FASTA file
    inputBinding:
      position: 2
  - id: fasta_y
    type: File
    doc: Second FASTA file
    inputBinding:
      position: 3
outputs:
  - id: alignments_file
    type: File
    doc: Output alignment file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gecko:1.2--h7b50bb2_6
