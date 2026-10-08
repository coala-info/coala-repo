cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-rename-fasta-headers
label: gtotree_gtt-rename-fasta-headers
doc: "Renames all sequences of a multifasta with the same name with an appended number to keep them unique.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Starting fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: wanted_name
    type:
      - 'null'
      - string
    doc: "Name to give seqs"
    default: Seq
    inputBinding:
      position: 2
      prefix: -w
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: "Output fasta file"
    default: Renamed.fasta
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: renamed_fasta
    type: File
    doc: "Renamed fasta file"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
