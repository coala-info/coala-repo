cwlVersion: v1.2
class: CommandLineTool
baseCommand: [LRez, index, bam]
label: mtglink_LRez_index_bam
doc: "Index the offsets or occurrence positions of the barcodes contained in a BAM file.\n\nTool homepage: https://github.com/anne-gcd/MTG-Link"
inputs:
  - id: bam
    type: File
    doc: "BAM file to index"
    secondaryFiles:
      - pattern: .bai
        required: false
    inputBinding:
      prefix: -b
  - id: output
    type: string
    doc: "File where to store the index"
    inputBinding:
      prefix: -o
  - id: offsets
    type: ['null', boolean]
    doc: "Index the offsets of the barcodes in the BAM file"
    inputBinding:
      prefix: -f
  - id: positions
    type: ['null', boolean]
    doc: "Index the (chromosome, begPosition) occurrence positions of the barcodes"
    inputBinding:
      prefix: -p
  - id: primary
    type: ['null', boolean]
    doc: "Only index barcodes that appear in a primary alignment (default: false)"
    inputBinding:
      prefix: -r
  - id: quality
    type: ['null', int]
    doc: "Only index barcodes that appear in an alignment of quality higher than this number (default: 0)"
    inputBinding:
      prefix: -q
  - id: threads
    type: ['null', int]
    doc: "Number of threads to use to build the index (default: 1)"
    inputBinding:
      prefix: -t
outputs:
  - id: result
    type: File
    doc: Barcode index
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mtglink:2.4.1--hdfd78af_0
