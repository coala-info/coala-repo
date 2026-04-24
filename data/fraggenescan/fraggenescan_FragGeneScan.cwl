cwlVersion: v1.2
class: CommandLineTool
baseCommand: FragGeneScan.pl
label: fraggenescan_FragGeneScan
doc: "Predicts genes in genomic sequences.\n\nTool homepage: https://sourceforge.net/projects/fraggenescan/"
inputs:
  - id: complete_genomic_sequences
    type: boolean
    doc: 1 if the sequence file has complete genomic sequences, 0 if the 
      sequence file has short sequence reads
    inputBinding:
      position: 101
      prefix: -w
  - id: seq_file_name
    type: File
    doc: sequence file name including the full path
    inputBinding:
      position: 101
      prefix: -s
  - id: thread_num
    type:
      - 'null'
      - int
    doc: the number of threads used by FragGeneScan
    inputBinding:
      position: 101
      prefix: -p
  - id: train_file_name
    type: string
    doc: file name that contains model parameters; this file should be in the 
      "train" directory
    inputBinding:
      position: 101
      prefix: -t
outputs:
  - id: output_file_name
    type: File
    doc: output file name including the full path
    outputBinding:
      glob: $(inputs.output_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
