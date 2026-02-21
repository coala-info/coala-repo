cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedToBigBed
label: ucsc-bedclip_bedToBigBed
doc: "Convert a BED file to a bigBed file. The input BED file must be sorted by chromosome
  and start position.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: Input BED file (must be sorted by chromosome and start position)
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: 'Two-column file: <chromosome name> <size in bases>'
    inputBinding:
      position: 2
  - id: as
    type:
      - 'null'
      - File
    doc: AutoSql file (.as) describing the fields
    inputBinding:
      position: 103
      prefix: -as
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
    default: 512
    inputBinding:
      position: 103
      prefix: -itemsPerSlot
  - id: tab
    type:
      - 'null'
      - boolean
    doc: If set, the input is tab-separated
    inputBinding:
      position: 103
      prefix: -tab
  - id: type
    type:
      - 'null'
      - string
    doc: Specify the number of columns in the BED file (e.g., bed3, bed3+1)
    inputBinding:
      position: 103
      prefix: -type
  - id: unc
    type:
      - 'null'
      - boolean
    doc: If set, do not use compression
    inputBinding:
      position: 103
      prefix: -unc
outputs:
  - id: output_bigbed
    type: File
    doc: Output bigBed file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedclip:482--h0b57e2e_0
