cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - LRez
  - index
  - bam
label: leviathan_LRez_index_bam
doc: "Index the offsets or occurrences positions of the barcodes contained in a BAM file.\n\nTool homepage: https://github.com/morispi/LEVIATHAN"
inputs:
  - id: bam
    type: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: 'BAM file to index'
    inputBinding:
      position: 1
      prefix: -b
  - id: output_file
    type: string
    doc: 'File where to store the index'
    inputBinding:
      position: 2
      prefix: -o
  - id: offsets
    type:
      - 'null'
      - boolean
    doc: 'Index the offsets of the barcodes in the BAM file'
    inputBinding:
      position: 3
      prefix: -f
  - id: positions
    type:
      - 'null'
      - boolean
    doc: 'Index the (chromosome, begPosition) occurrences positions of the barcodes'
    inputBinding:
      position: 4
      prefix: -p
  - id: primary
    type:
      - 'null'
      - boolean
    doc: 'Only index barcodes that appear in a primary alignment (default: false)'
    inputBinding:
      position: 5
      prefix: -r
  - id: quality
    type:
      - 'null'
      - int
    doc: 'Only index barcodes that appear in an alignment of quality higher than this number (default: 0)'
    inputBinding:
      position: 6
      prefix: -q
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads to use to build the index (default: 1)'
    inputBinding:
      position: 7
      prefix: -t
outputs:
  - id: output
    type: File
    doc: 'The barcode index'
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/leviathan:1.0.2--h9948957_4
