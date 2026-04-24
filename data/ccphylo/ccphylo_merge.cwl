cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_merge
label: ccphylo_merge
doc: "Merges matrices from a multi Phylip file into one matrix\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: byte_precision
    type:
      - 'null'
      - string
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
      - string
    doc: Float precision on distance matrix
    inputBinding:
      position: 101
      prefix: --float_precision
  - id: input_file
    type:
      - 'null'
      - File
    doc: Input multi phylip distance file
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
  - id: nucleotide_numbers
    type:
      - 'null'
      - boolean
    doc: Output number of nucleotides included
    inputBinding:
      position: 101
      prefix: --nucleotide_numbers
  - id: nucleotides_weights
    type:
      - 'null'
      - File
    doc: Weigh distance with this Phylip file
    inputBinding:
      position: 101
      prefix: --nucleotides_weights
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
      - string
    doc: Short precision on distance matrix
    inputBinding:
      position: 101
      prefix: --short_precision
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
