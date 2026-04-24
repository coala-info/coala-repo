cwlVersion: v1.2
class: CommandLineTool
baseCommand: str index
label: strling_index
doc: "Index a FASTA file for STR analysis.\n\nTool homepage: https://github.com/quinlan-lab/STRling"
inputs:
  - id: fasta
    type: File
    doc: path to fasta file
    inputBinding:
      position: 1
  - id: proportion_repeat
    type:
      - 'null'
      - float
    doc: proportion of read that is repetitive to be considered as STR
    inputBinding:
      position: 102
      prefix: --proportion-repeat
outputs:
  - id: genome_repeats
    type:
      - 'null'
      - File
    doc: optional path to output genome repeats file. if it does not exist, it 
      will be created
    outputBinding:
      glob: $(inputs.genome_repeats)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/strling:0.6.0--h7b50bb2_0
