cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedToBed
label: ucsc-bigbedtobed
doc: "Convert from bigBed to ascii bed format.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_big_bed
    type: File
    doc: Input bigBed file
    inputBinding:
      position: 1
  - id: output_bed
    type: string
    doc: Name of the output BED file
    inputBinding:
      position: 2
  - id: chrom
    type:
      - 'null'
      - string
    doc: If set restrict output to given chromosome
    inputBinding:
      position: 101
      prefix: -chrom=
      separate: false
  - id: start
    type:
      - 'null'
      - int
    doc: If set, restrict output to only that over start
    inputBinding:
      position: 101
      prefix: -start=
      separate: false
  - id: end
    type:
      - 'null'
      - int
    doc: If set, restrict output to only that under end
    inputBinding:
      position: 101
      prefix: -end=
      separate: false
  - id: bed
    type:
      - 'null'
      - File
    doc: Restrict output to all regions in a BED file
    inputBinding:
      position: 101
      prefix: -bed=
      separate: false
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: Place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 101
      prefix: -udcDir=
      separate: false
  - id: header
    type:
      - 'null'
      - boolean
    doc: Output a autoSql-style header (starts with '#').
    inputBinding:
      position: 101
      prefix: -header
  - id: tsv
    type:
      - 'null'
      - boolean
    doc: Output a TSV header (without '#').
    inputBinding:
      position: 101
      prefix: -tsv
outputs:
  - id: out_output_bed
    type: File
    doc: Output BED file
    outputBinding:
      glob: $(inputs.output_bed)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbedtobed:482--h0b57e2e_0
