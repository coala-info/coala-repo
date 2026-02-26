cwlVersion: v1.2
class: CommandLineTool
baseCommand: wigToBigWig
label: ucsc-wigtobigwig
doc: "Convert ASCII wig file to binary bigWig format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_wig
    type: File
    doc: Input wig file
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two column: name, size)'
    inputBinding:
      position: 2
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree
    default: 256
    inputBinding:
      position: 103
      prefix: -blockSize
  - id: clip
    type:
      - 'null'
      - boolean
    doc: If set, clip items that are off the end of a chromosome
    inputBinding:
      position: 103
      prefix: -clip
  - id: fixed_summaries
    type:
      - 'null'
      - boolean
    doc: If set, use fixed-width summary levels
    inputBinding:
      position: 103
      prefix: -fixedSummaries
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of data points bundled at lowest level
    default: 1024
    inputBinding:
      position: 103
      prefix: -itemsPerSlot
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression
    inputBinding:
      position: 103
      prefix: -unc
outputs:
  - id: output_bw
    type: File
    doc: Output bigWig file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-wigtobigwig:482--hdc0a859_1
