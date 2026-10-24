cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigWigInfo
label: ucsc-bigwiginfo
doc: "Print out information about bigWig file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: "Input bigWig file"
    inputBinding:
      position: 1
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: "Place to put cache for remote bigBed/bigWigs"
    inputBinding:
      position: 101
      prefix: -udcDir=
      separate: false
  - id: chroms
    type:
      - 'null'
      - boolean
    doc: "List all chromosomes and their sizes"
    inputBinding:
      position: 101
      prefix: -chroms
  - id: zooms
    type:
      - 'null'
      - boolean
    doc: "List all zoom levels and their sizes"
    inputBinding:
      position: 101
      prefix: -zooms
  - id: min_max
    type:
      - 'null'
      - boolean
    doc: "List the min and max on a single line"
    inputBinding:
      position: 101
      prefix: -minMax
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigwiginfo:482--h0b57e2e_0
stdout: ucsc-bigwiginfo.out
