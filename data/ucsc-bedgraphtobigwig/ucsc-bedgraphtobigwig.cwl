cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedGraphToBigWig
label: ucsc-bedgraphtobigwig
doc: "Convert a bedGraph file to bigWig format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bedgraph
    type: File
    doc: Input bedGraph file
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Chromosome sizes file (two columns: <chromName> <size>)'
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
  - id: output_bigwig
    type: File
    doc: Output bigWig file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedgraphtobigwig:482--hdc0a859_0
