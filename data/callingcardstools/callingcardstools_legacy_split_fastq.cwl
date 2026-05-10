cwlVersion: v1.2
class: CommandLineTool
baseCommand: legacy_split_fastq
label: callingcardstools_legacy_split_fastq
doc: "Splits paired-end FASTQ files based on barcodes.\n\nTool homepage: https://github.com/cmatKhan/callingCardsTools"
inputs:
  - id: barcodefile
    type:
      - 'null'
      - File
    doc: barcode filename (full path)
    inputBinding:
      position: 101
      prefix: --barcodefile
  - id: hammp
    type:
      - 'null'
      - int
    doc: Primer barcode hamming distance
    inputBinding:
      position: 101
      prefix: --hammp
  - id: hammt
    type:
      - 'null'
      - int
    doc: Transposon barcode hamming distance
    inputBinding:
      position: 101
      prefix: --hammt
  - id: log_level
    type:
      - 'null'
      - string
    doc: logging level
    inputBinding:
      position: 101
      prefix: --log_level
  - id: read1
    type: File
    doc: Read 1 filename (full path)
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type: File
    doc: Read2 filename (full path)
    inputBinding:
      position: 101
      prefix: --read2
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type:
      - 'null'
      - Directory
    doc: path to output directory
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callingcardstools:1.8.1--pyhdfd78af_0
