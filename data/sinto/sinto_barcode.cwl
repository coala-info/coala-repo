cwlVersion: v1.2
class: CommandLineTool
baseCommand: sinto_barcode
label: sinto_barcode
doc: "Add cell barcode sequences to read names in FASTQ file.\n\nTool homepage: https://timoast.github.io/sinto/"
inputs:
  - id: barcode_fastq
    type: File
    doc: FASTQ file containing cell barcode sequences
    inputBinding:
      position: 101
      prefix: --barcode_fastq
  - id: bases
    type: int
    doc: Number of bases to extract from barcode-containing FASTQ
    inputBinding:
      position: 101
      prefix: --bases
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to cell barcodes
    inputBinding:
      position: 101
      prefix: --prefix
  - id: read1
    type: File
    doc: FASTQ file containing read 1
    inputBinding:
      position: 101
      prefix: --read1
  - id: read2
    type:
      - 'null'
      - File
    doc: FASTQ file containing read 2
    inputBinding:
      position: 101
      prefix: --read2
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix to add to cell barcodes
    inputBinding:
      position: 101
      prefix: --suffix
  - id: whitelist
    type:
      - 'null'
      - File
    doc: Text file containing barcode whitelist
    inputBinding:
      position: 101
      prefix: --whitelist
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sinto:0.10.1--pyhdfd78af_0
stdout: sinto_barcode.out
