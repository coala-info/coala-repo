cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_dbscan
label: ccphylo_dbscan
doc: "make a DBSCAN given a set of phylip distance matrices.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: byte_precision
    type:
      - 'null'
      - string
    doc: Byte precision on distance matrix
    default: double / 1e0
    inputBinding:
      position: 101
      prefix: --byte_precision
  - id: float_precision
    type:
      - 'null'
      - string
    doc: Float precision on distance matrix
    default: double
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
  - id: max_distance
    type:
      - 'null'
      - float
    doc: Maximum distance
    default: 10.0
    inputBinding:
      position: 101
      prefix: --max_distance
  - id: min_neighbors
    type:
      - 'null'
      - int
    doc: Minimum neighbors
    default: 1
    inputBinding:
      position: 101
      prefix: --min_neighbors
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: Allocate matrix on the disk
    default: false
    inputBinding:
      position: 101
      prefix: --mmap
  - id: quotes
    type:
      - 'null'
      - string
    doc: Quote taxa
    default: \0
    inputBinding:
      position: 101
      prefix: --quotes
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
    default: double / 1e0
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
