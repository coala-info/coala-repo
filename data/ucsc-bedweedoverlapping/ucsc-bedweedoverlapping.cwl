cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedWeedOverlapping
label: ucsc-bedweedoverlapping
doc: "Filter out beds that overlap a 'weed.bed' file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: weeds_bed
    type: File
    doc: BED file with the regions to weed out (overlapping records are removed)
    inputBinding:
      position: 1
  - id: input_bed
    type: File
    doc: Input BED file to filter
    inputBinding:
      position: 2
  - id: output_bed
    type: string
    doc: Name of the output BED file
    inputBinding:
      position: 3
  - id: max_overlap
    type:
      - 'null'
      - float
    doc: Maximum overlapping ratio, default 0 (any overlap)
    inputBinding:
      position: 101
      prefix: -maxOverlap=
      separate: false
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Keep the overlapping and get rid of everything else
    inputBinding:
      position: 101
      prefix: -invert
outputs:
  - id: out_output_bed
    type: File
    doc: Filtered BED file
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedweedoverlapping:482--h0b57e2e_0
