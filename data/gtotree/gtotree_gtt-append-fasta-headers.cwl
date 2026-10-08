cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-append-fasta-headers
label: gtotree_gtt-append-fasta-headers
doc: "Modifies headers of sequences of a multifasta, specific for use in GToTree.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Starting fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: desired_append
    type:
      - 'null'
      - string
    doc: "Name to append to seqs"
    default: Seq
    inputBinding:
      position: 2
      prefix: -w
  - id: output_fasta_name
    type:
      - 'null'
      - string
    doc: "Output fasta file"
    default: Renamed.fasta
    inputBinding:
      position: 3
      prefix: -o
outputs:
  - id: output_fasta
    type: File
    doc: "Output fasta file"
    outputBinding:
      glob: $(inputs.output_fasta_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
