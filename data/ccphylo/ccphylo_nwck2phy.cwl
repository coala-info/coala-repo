cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_nwck2phy
label: ccphylo_nwck2phy
doc: "converts newick files to phylip distance files.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: byte_precision
    type:
      - 'null'
      - boolean
    doc: Byte precision on distance matrix
    inputBinding:
      position: 101
      prefix: --byte_precision
  - id: flag
    type:
      - 'null'
      - int
    doc: Output flags
    default: 1
    inputBinding:
      position: 101
      prefix: --flag
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
    doc: Input file
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: Allocate matrix on the disk
    default: false
    inputBinding:
      position: 101
      prefix: --mmap
  - id: print_precision
    type:
      - 'null'
      - int
    doc: Floating point print precision
    default: 9
    inputBinding:
      position: 101
      prefix: --print_precision
  - id: short_precision
    type:
      - 'null'
      - boolean
    doc: Short precision on distance matrix
    inputBinding:
      position: 101
      prefix: --short_precision
  - id: tmp
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
