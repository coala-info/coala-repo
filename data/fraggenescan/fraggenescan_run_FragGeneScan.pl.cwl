cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_FragGeneScan.pl
label: fraggenescan_run_FragGeneScan.pl
doc: "Predicts genes in genomic sequences and short reads (Perl wrapper that calls
  the FragGeneScan binary with its bundled model files).\n\nTool homepage: https://sourceforge.net/projects/fraggenescan/"
inputs:
  - id: genome
    type: File
    doc: sequence file name including the full path
    inputBinding:
      position: 1
      prefix: -genome=
      separate: false
  - id: out
    type: string
    doc: output file name including the full path; FragGeneScan appends .out, .faa,
      .ffn and .gff
    inputBinding:
      position: 2
      prefix: -out=
      separate: false
  - id: complete
    type: int
    doc: 1 if the sequence file has complete genomic sequences, 0 if the sequence
      file has short sequence reads
    inputBinding:
      position: 3
      prefix: -complete=
      separate: false
  - id: train
    type: string
    doc: file name that contains model parameters; this file should be in the "train"
      directory (complete, sanger_5, sanger_10, 454_10, 454_30, illumina_5, illumina_10)
    inputBinding:
      position: 4
      prefix: -train=
      separate: false
  - id: thread
    type:
      - 'null'
      - int
    doc: number of threads used by FragGeneScan; default 1
    inputBinding:
      position: 5
      prefix: -thread=
      separate: false
outputs:
  - id: out_file
    type: File
    doc: predicted gene coordinates (<out>.out)
    outputBinding:
      glob: $(inputs.out).out
  - id: faa_file
    type: File
    doc: predicted proteins (<out>.faa)
    outputBinding:
      glob: $(inputs.out).faa
  - id: ffn_file
    type: File
    doc: predicted gene nucleotide sequences (<out>.ffn)
    outputBinding:
      glob: $(inputs.out).ffn
  - id: gff_file
    type:
      - 'null'
      - File
    doc: predicted genes in GFF format (<out>.gff)
    outputBinding:
      glob: $(inputs.out).gff
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraggenescan:1.32--h7b50bb2_1
