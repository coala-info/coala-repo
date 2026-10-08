cwlVersion: v1.2
class: CommandLineTool
baseCommand: /usr/local/bin/FragGeneScan
label: fraggenescan_FragGeneScan
doc: "Predicts genes in genomic sequences and short reads (FragGeneScan binary). It\
  \ finds the model files in the train directory beside the program, so it must be\
  \ started with its full path.\n\nTool homepage: https://sourceforge.net/projects/fraggenescan/"
inputs:
  - id: complete_genomic_sequences
    type: int
    doc: 1 if the sequence file has complete genomic sequences, 0 if the sequence
      file has short sequence reads
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
    doc: file name that contains model parameters; this file should be in the "train"
      directory (complete, sanger_5, sanger_10, 454_5, 454_10, 454_30, illumina_5,
      illumina_10)
    inputBinding:
      position: 101
      prefix: -t
  - id: output_file_name_path
    type: string
    doc: output file name including the full path; FragGeneScan appends .out, .faa,
      .ffn and .gff
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: out_file
    type: File
    doc: predicted gene coordinates (<output>.out)
    outputBinding:
      glob: $(inputs.output_file_name_path).out
  - id: faa_file
    type: File
    doc: predicted proteins (<output>.faa)
    outputBinding:
      glob: $(inputs.output_file_name_path).faa
  - id: ffn_file
    type: File
    doc: predicted gene nucleotide sequences (<output>.ffn)
    outputBinding:
      glob: $(inputs.output_file_name_path).ffn
  - id: gff_file
    type:
      - 'null'
      - File
    doc: predicted genes in GFF format (<output>.gff)
    outputBinding:
      glob: $(inputs.output_file_name_path).gff
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
