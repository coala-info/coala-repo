cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-swap-ids
label: gtotree_gtt-swap-ids
doc: "Swaps the headers of a fasta file.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Starting fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: id_map
    type:
      - 'null'
      - File
    doc: "Two column tab-delimited file where column 1 holds the original headers and column 2 holds the desired headers (does not need to hold all headers)"
    inputBinding:
      position: 2
      prefix: -s
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
  - id: renamed_fasta
    type: File
    doc: "Fasta file with swapped headers"
    outputBinding:
      glob: $(inputs.output_fasta_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
