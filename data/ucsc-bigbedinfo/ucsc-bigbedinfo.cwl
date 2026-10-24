cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedInfo
label: ucsc-bigbedinfo
doc: "Show information about a bigBed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: big_bed_file
    type: File
    doc: The bigBed file to provide information for.
    inputBinding:
      position: 1
  - id: udc_dir
    type:
      - 'null'
      - string
    doc: Place to put cache for remote bigBed/bigWigs
    inputBinding:
      position: 101
      prefix: -udcDir=
      separate: false
  - id: chroms
    type:
      - 'null'
      - boolean
    doc: List all chromosomes and their sizes.
    inputBinding:
      position: 101
      prefix: -chroms
  - id: zooms
    type:
      - 'null'
      - boolean
    doc: List all zoom levels and their sizes.
    inputBinding:
      position: 101
      prefix: -zooms
  - id: as
    type:
      - 'null'
      - boolean
    doc: Get autoSql spec.
    inputBinding:
      position: 101
      prefix: -as
  - id: as_out
    type:
      - 'null'
      - boolean
    doc: Output only autoSql spec.
    inputBinding:
      position: 101
      prefix: -asOut
  - id: extra_index
    type:
      - 'null'
      - boolean
    doc: List all the extra indexes.
    inputBinding:
      position: 101
      prefix: -extraIndex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbedinfo:482--h0b57e2e_0
stdout: ucsc-bigbedinfo.out
