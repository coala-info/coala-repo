cwlVersion: v1.2
class: CommandLineTool
baseCommand: crTreeIndexBed
label: ucsc-crtreeindexbed
doc: "Create an index for a bed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: in_bed
    type: File
    doc: Input BED file, sorted by chromosome and start.
    inputBinding:
      position: 1
  - id: out_cr
    type: string
    doc: Output crTree index file name.
    inputBinding:
      position: 2
  - id: block_size
    type:
      - 'null'
      - int
    doc: Number of children per node in index tree. Default 1024.
    inputBinding:
      position: 101
      prefix: -blockSize=
      separate: false
  - id: items_per_slot
    type:
      - 'null'
      - int
    doc: Number of items per index slot. Default is half block size.
    inputBinding:
      position: 101
      prefix: -itemsPerSlot=
      separate: false
  - id: no_check_sort
    type:
      - 'null'
      - boolean
    doc: Don't check sorting order of the input.
    inputBinding:
      position: 101
      prefix: -noCheckSort
outputs:
  - id: output_cr
    type: File
    doc: Output crTree index file.
    outputBinding:
      glob: $(inputs.out_cr)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-crtreeindexbed:482--h0b57e2e_0
