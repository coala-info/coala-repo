cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigSummary
label: ucsc-bigwigsummary
doc: "Extract summary information from a bigWig file.\nGet summary data from bigWig for indicated region, broken into dataPoints equal parts. (Use dataPoints=1 for simple summary.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: "Input bigWig file"
    inputBinding:
      position: 1
  - id: chrom
    type: string
    doc: "Chromosome name"
    inputBinding:
      position: 2
  - id: start
    type: int
    doc: "Start of region (BED format, 0-based)"
    inputBinding:
      position: 3
  - id: end
    type: int
    doc: "End of region"
    inputBinding:
      position: 4
  - id: data_points
    type: int
    doc: "Number of equal parts the region is broken into"
    inputBinding:
      position: 5
  - id: type
    type:
      - 'null'
      - string
    doc: "Summary type: mean (default), min, max, std or coverage"
    inputBinding:
      position: 101
      prefix: -type=
      separate: false
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: "Place to put cache for remote bigBed/bigWigs"
    inputBinding:
      position: 101
      prefix: -udcDir=
      separate: false
outputs:
  - id: stdout
    type: stdout
    doc: "Summary values"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwigsummary:482--h0b57e2e_0
stdout: ucsc-bigwigsummary.out
