cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_tree
label: ccphylo_tree
doc: "forms tree(s) in newick format given a set of phylip distance matrices.\n\n\
  Tool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
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
  - id: free
    type:
      - 'null'
      - boolean
    doc: Gradually free up D
    inputBinding:
      position: 101
      prefix: --free
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input file
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: Tree construction method.
    inputBinding:
      position: 101
      prefix: --method
  - id: method_help
    type:
      - 'null'
      - boolean
    doc: Help on option "-m"
    inputBinding:
      position: 101
      prefix: --method_help
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
  - id: print_precision
    type:
      - 'null'
      - int
    doc: Floating point print precision
    inputBinding:
      position: 101
      prefix: --print_precision
  - id: quotes
    type:
      - 'null'
      - string
    doc: Quote taxa
    inputBinding:
      position: 101
      prefix: --quotes
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
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmp_dir
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
