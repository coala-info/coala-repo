cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - alfred
  - bcsplit
label: alfred_bcsplit
doc: "Split FASTQ files based on barcodes and UMIs\n\nTool homepage: https://github.com/tobiasrausch/alfred"
inputs:
  - id: reads_file
    type: File
    doc: Input reads FASTQ file
    inputBinding:
      position: 1
  - id: barcodes
    type: File
    doc: barcode file [barcode, id]
    inputBinding:
      position: 102
      prefix: --barcodes
  - id: hamming
    type:
      - 'null'
      - int
    doc: max. hamming distance to barcode
    inputBinding:
      position: 102
      prefix: --hamming
  - id: idxfile
    type: File
    doc: input index FASTQ file
    inputBinding:
      position: 102
      prefix: --idxfile
  - id: ncount
    type:
      - 'null'
      - int
    doc: max. number of Ns per barcode
    inputBinding:
      position: 102
      prefix: --ncount
  - id: pattern
    type:
      - 'null'
      - string
    doc: 'index read pattern [U: UMI, B: Barcode, N: Ignore]'
    inputBinding:
      position: 102
      prefix: --pattern
outputs:
  - id: outprefix
    type:
      - 'null'
      - File
    doc: output prefix
    outputBinding:
      glob: $(inputs.outprefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/alfred:0.5.1--h4d20210_0
