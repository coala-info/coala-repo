cwlVersion: v1.2
class: CommandLineTool
baseCommand: bam-extractor
label: trust4_bam-extractor
doc: "Extract candidate TCR/BCR reads from a BAM file (first step of TRUST4 for aligned data).\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: fasta_file
    type: File
    doc: "fasta file containing the receptor genome sequence"
    inputBinding:
      position: 101
      prefix: -f
  - id: bam_file
    type: File
    doc: "path to BAM file"
    inputBinding:
      position: 101
      prefix: -b
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "prefix to the output file"
    inputBinding:
      position: 101
      prefix: -o
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads (default: 1)"
    inputBinding:
      position: 101
      prefix: -t
  - id: unaligned_unordinary
    type:
      - 'null'
      - boolean
    doc: "the flag or order of unaligned read-pair is not ordinary (default: not used)"
    inputBinding:
      position: 101
      prefix: -u
  - id: barcode
    type:
      - 'null'
      - string
    doc: "the barcode field in the bam file (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcode
  - id: umi
    type:
      - 'null'
      - string
    doc: "the UMI field in the bam file (default: not used)"
    inputBinding:
      position: 101
      prefix: --UMI
  - id: mate_id_suffix_len
    type:
      - 'null'
      - int
    doc: "the suffix length in read id for mate (default: not used)"
    inputBinding:
      position: 101
      prefix: --mateIdSuffixLen
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Candidate read files written with the output prefix"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'bamextract') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
