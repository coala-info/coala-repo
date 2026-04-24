cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedToBigBed
label: ucsc-bedtobigbed
doc: "Convert a BED file to a bigBed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_bed
    type: File
    doc: The input BED file to be converted.
    inputBinding:
      position: 1
  - id: chrom_sizes
    type: File
    doc: A file containing chromosome names and sizes.
    inputBinding:
      position: 2
  - id: as
    type:
      - 'null'
      - File
    doc: AutoSql file (.as) describing the fields.
    inputBinding:
      position: 103
      prefix: -as
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of items to bundle in r-tree.
    inputBinding:
      position: 103
      prefix: -blockSize
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of data points bundled at lowest level.
    inputBinding:
      position: 103
      prefix: -itemsPerSlot
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Input is tab-separated.
    inputBinding:
      position: 103
      prefix: -tab
  - id: type
    type:
      - 'null'
      - string
    doc: Specifies the BED type (e.g., bed3, bed3+1, bed6+4).
    inputBinding:
      position: 103
      prefix: -type
  - id: unc
    type:
      - 'null'
      - boolean
    doc: Disable compression.
    inputBinding:
      position: 103
      prefix: -unc
outputs:
  - id: output_bigbed
    type: File
    doc: The resulting bigBed output file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedtobigbed:482--hdc0a859_0
