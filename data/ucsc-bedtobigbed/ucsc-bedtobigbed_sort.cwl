cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToBigBed
label: ucsc-bedtobigbed_sort
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
    doc: 'Chromosome sizes file (two columns: <chromosome_name> <size_in_bases>)'
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
    doc: Number of items to bundle in r-tree internal nodes
    default: 256
    inputBinding:
      position: 103
      prefix: -blockSize
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree leaf nodes
    default: 1024
    inputBinding:
      position: 103
      prefix: -itemsPerSlot
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Input is tab-separated
    inputBinding:
      position: 103
      prefix: -tab
  - id: type
    type:
      - 'null'
      - string
    doc: BED N[+P] format (e.g., bed3, bed6+4)
    inputBinding:
      position: 103
      prefix: -type
  - id: unc
    type:
      - 'null'
      - boolean
    doc: Disable compression
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
    dockerPull: quay.io/biocontainers/ucsc-bedtobigbed:482--hdc0a859_0
