cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-remove-all-gap-seqs-from-alignment
label: gtotree_gtt-remove-all-gap-seqs-from-alignment
doc: "Removes sequences that are entirely gap characters (\"-\") from an alignment fasta file, specific for use in GToTree.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Starting fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_fasta
    type:
      - 'null'
      - string
    doc: "Output fasta file"
    default: No-gap-seqs-aln.faa
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_aln
    type: File
    doc: "Alignment without all-gap sequences"
    outputBinding:
      glob: $(inputs.output_fasta)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
