cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedInfo
label: ucsc-bigbedtobed_bigBedInfo
doc: "Show information about a bigBed file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: The input .bb file
    inputBinding:
      position: 1
  - id: chroms
    type:
      - 'null'
      - boolean
    doc: List all chromosomes in the bigBed file
    inputBinding:
      position: 102
      prefix: -chroms
  - id: extra_index
    type:
      - 'null'
      - boolean
    doc: List all extra indexes
    inputBinding:
      position: 102
      prefix: -extraIndex
  - id: udc_dir
    type:
      - 'null'
      - Directory
    doc: Path to udc cache
    inputBinding:
      position: 102
      prefix: -udcDir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbedtobed:482--h0b57e2e_0
stdout: ucsc-bigbedtobed_bigBedInfo.out
