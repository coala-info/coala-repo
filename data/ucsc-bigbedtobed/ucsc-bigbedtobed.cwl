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
  - id: chrom
    type:
      - 'null'
      - string
    doc: If set, restrict output to given chromosome
    inputBinding:
      position: 102
      prefix: -chrom
  - id: end
    type:
      - 'null'
      - int
    doc: If set, restrict output to only that under end
    inputBinding:
      position: 102
      prefix: -end
  - id: max_items
    type:
      - 'null'
      - int
    doc: If set, restrict output to first N items
    inputBinding:
      position: 102
      prefix: -maxItems
  - id: start
    type:
      - 'null'
      - int
    doc: If set, restrict output to only that over start
    inputBinding:
      position: 102
      prefix: -start
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Specify directory for udc cache
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: output_bed
    type: File
    doc: Output bed file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbedtobed:482--h0b57e2e_0
