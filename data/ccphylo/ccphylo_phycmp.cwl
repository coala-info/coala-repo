cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_phycmp
label: ccphylo_phycmp
doc: "Compares two distance matrices in phylip format.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: byte_precision
    type:
      - 'null'
      - boolean
    doc: Byte precision on distance matrix
    inputBinding:
      position: 101
      prefix: --byte_precision
  - id: flag_help
    type:
      - 'null'
      - boolean
    doc: Help on option "-f"
    inputBinding:
      position: 101
      prefix: --flag_help
  - id: float_precision
    type:
      - 'null'
      - boolean
    doc: Float precision on distance matrix
    inputBinding:
      position: 101
      prefix: --float_precision
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file(s)
    inputBinding:
      position: 101
      prefix: --input
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: Allocate matrix on the disk
    inputBinding:
      position: 101
      prefix: --mmap
  - id: output_flags
    type:
      - 'null'
      - int
    doc: Output flags
    inputBinding:
      position: 101
      prefix: --flag
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator
    inputBinding:
      position: 101
      prefix: --separator
  - id: short_precision
    type:
      - 'null'
      - boolean
    doc: Short precision on distance matrix
    inputBinding:
      position: 101
      prefix: --short_precision
  - id: tmp_directory
    type:
      - 'null'
      - Directory
    doc: Set directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmp
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ccphylo:0.8.2--h577a1d6_3
