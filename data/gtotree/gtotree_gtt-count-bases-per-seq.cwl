cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtt-count-bases-per-seq
label: gtotree_gtt-count-bases-per-seq
doc: "Takes a multifasta as input and returns a tab-delimited file with two columns, header and number of bases or amino acids, for each sequence.

Tool homepage: https://github.com/AstrobioMike/GToTree"
inputs:
  - id: input_fasta
    type: File
    doc: "Original fasta file"
    inputBinding:
      position: 1
      prefix: -i
  - id: output_txt_file
    type:
      - 'null'
      - string
    doc: "Name of output txt file"
    default: Num_bps.txt
    inputBinding:
      position: 2
      prefix: -o
outputs:
  - id: output_txt
    type: File
    doc: "Tab-delimited table of sequence lengths"
    outputBinding:
      glob: $(inputs.output_txt_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtotree:1.8.16--h9ee0642_2
