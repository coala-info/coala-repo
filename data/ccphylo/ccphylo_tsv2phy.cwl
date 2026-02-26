cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_tsv2phy
label: ccphylo_tsv2phy
doc: "converts tsv files to phylip distance files.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: byte_precision
    type:
      - 'null'
      - string
    doc: Byte precision on distance matrix
    default: False / double / 1e0
    inputBinding:
      position: 101
      prefix: --byte_precision
  - id: distance_help
    type:
      - 'null'
      - boolean
    doc: Help on option "-d"
    inputBinding:
      position: 101
      prefix: --distance_help
  - id: distance_method
    type:
      - 'null'
      - string
    doc: Distance method
    default: cos
    inputBinding:
      position: 101
      prefix: --distance
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
      - string
    doc: Float precision on distance matrix
    default: False / double
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
  - id: output_flags
    type:
      - 'null'
      - int
    doc: Output flags
    default: 1
    inputBinding:
      position: 101
      prefix: --flag
  - id: print_precision
    type:
      - 'null'
      - int
    doc: Floating point print precision
    default: 9
    inputBinding:
      position: 101
      prefix: --print_precision
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator
    default: \t
    inputBinding:
      position: 101
      prefix: --separator
  - id: short_precision
    type:
      - 'null'
      - string
    doc: Short precision on distance matrix
    default: False / double / 1e0
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
