cwlVersion: v1.2
class: CommandLineTool
baseCommand: idemux
label: idemux
doc: "A tool to demultiplex fastq files based on Lexogen i7,i5,i1 barcodes.\n\nTool
  homepage: https://github.com/lexogen-tools/idemux"
inputs:
  - id: i1_start
    type:
      - 'null'
      - int
    doc: start position of the i1 index (1-based) on read 2
    default: 11
    inputBinding:
      position: 101
      prefix: --i1-start
  - id: i5_rc
    type:
      - 'null'
      - boolean
    doc: when the i5 barcode has been sequenced as reverse complement. make sure
      to enter non-reverse complement sequences in the barcode file
    inputBinding:
      position: 101
      prefix: --i5-rc
  - id: read1
    type: File
    doc: gzipped read 1 fastq file
    inputBinding:
      position: 101
      prefix: --r1
  - id: read2
    type: File
    doc: path to gzipped read 2 fastq file
    inputBinding:
      position: 101
      prefix: --r2
  - id: sample_sheet
    type: File
    doc: csv file describing sample names, and barcode combinations
    inputBinding:
      position: 101
      prefix: --sample-sheet
outputs:
  - id: output_dir
    type: Directory
    doc: where to write the output files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/idemux:0.1.6--pyhdfd78af_0
