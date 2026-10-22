cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastq-extractor
label: trust4_fastq-extractor
doc: "Extract candidate TCR/BCR reads from FASTQ files (first step of TRUST4).\n\nTool homepage: https://github.com/liulab-dfci/TRUST4"
inputs:
  - id: fasta_file
    type: File
    doc: "fasta file containing the receptor genome sequence"
    inputBinding:
      position: 101
      prefix: -f
  - id: single_end_read
    type:
      - 'null'
      - File
    doc: "path to single-end read file"
    inputBinding:
      position: 101
      prefix: -u
  - id: read1
    type:
      - 'null'
      - File
    doc: "path to paired-end read file 1"
    inputBinding:
      position: 101
      prefix: "-1"
  - id: read2
    type:
      - 'null'
      - File
    doc: "path to paired-end read file 2"
    inputBinding:
      position: 101
      prefix: "-2"
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: "prefix to the output file (default: toassemble)"
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
  - id: barcode
    type:
      - 'null'
      - File
    doc: "path to the raw barcode file (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcode
  - id: barcode_whitelist
    type:
      - 'null'
      - File
    doc: "path to the barcode whitelist (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcodeWhitelist
  - id: barcode_translate
    type:
      - 'null'
      - File
    doc: "path to the barcode translate file (default: not used)"
    inputBinding:
      position: 101
      prefix: --barcodeTranslate
  - id: umi
    type:
      - 'null'
      - File
    doc: "path to the raw UMI file (default: not used)"
    inputBinding:
      position: 101
      prefix: --UMI
  - id: read_format
    type:
      - 'null'
      - string
    doc: "format for read, barcode and UMI files (example: r1:0:-1,r2:0:-1,bc:0:15,um:16:-1)"
    inputBinding:
      position: 101
      prefix: --readFormat
  - id: skip_barcode_error_read
    type:
      - 'null'
      - boolean
    doc: "do not output reads that failed barcode correction or barcode translation"
    inputBinding:
      position: 101
      prefix: --skipBarcodeErrorRead
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: "Candidate read files (prefix_1.fq, prefix_2.fq or prefix.fq)"
    outputBinding:
      glob: "$((inputs.output_prefix ? inputs.output_prefix : 'toassemble') + '*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/trust4:1.1.8--h5ca1c30_0
