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
  - id: chroms
    type:
      - 'null'
      - boolean
    doc: List all chromosomes in the file.
    inputBinding:
      position: 102
      prefix: -chroms
  - id: extra_index
    type:
      - 'null'
      - boolean
    doc: List all extra indices.
    inputBinding:
      position: 102
      prefix: -extraIndex
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Place to keep udc cache.
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbedinfo:482--h0b57e2e_0
stdout: ucsc-bigbedinfo.out
