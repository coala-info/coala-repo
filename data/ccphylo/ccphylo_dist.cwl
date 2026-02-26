cwlVersion: v1.2
class: CommandLineTool
baseCommand: ccphylo_dist
label: ccphylo_dist
doc: "calculates distances between samples based on overlaps between nucleotide count
  matrices created by e.g. KMA.\n\nTool homepage: https://bitbucket.org/genomicepidemiology/ccphylo"
inputs:
  - id: add_file
    type:
      - 'null'
      - File
    doc: Add file to existing matrix
    inputBinding:
      position: 101
      prefix: --add
  - id: byte_precision
    type:
      - 'null'
      - string
    doc: Byte precision on distance matrix
    default: double / 1e0
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
    default: double
    inputBinding:
      position: 101
      prefix: --float_precision
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input file(s)
    default: stdin
    inputBinding:
      position: 101
      prefix: --input
  - id: methylation_motifs
    type:
      - 'null'
      - File
    doc: Mask methylation motifs from <file>
    default: False/None
    inputBinding:
      position: 101
      prefix: --methylation_motifs
  - id: min_cov
    type:
      - 'null'
      - string
    doc: Minimum coverage
    default: 50.0%
    inputBinding:
      position: 101
      prefix: --min_cov
  - id: min_depth
    type:
      - 'null'
      - int
    doc: Minimum depth
    default: 15
    inputBinding:
      position: 101
      prefix: --min_depth
  - id: min_len
    type:
      - 'null'
      - int
    doc: Minimum overlapping length
    default: 1
    inputBinding:
      position: 101
      prefix: --min_len
  - id: mmap
    type:
      - 'null'
      - boolean
    doc: Allocate matrix on the disk
    default: false
    inputBinding:
      position: 101
      prefix: --mmap
  - id: normalization_weight
    type:
      - 'null'
      - string
    doc: Normalization weight
    default: 0 / None
    inputBinding:
      position: 101
      prefix: --normalization_weight
  - id: nucleotide_numbers
    type:
      - 'null'
      - boolean
    doc: Output number of nucleotides included
    default: false
    inputBinding:
      position: 101
      prefix: --nucleotide_numbers
  - id: nucleotide_variations
    type:
      - 'null'
      - boolean
    doc: Output nucleotide variations
    default: false
    inputBinding:
      position: 101
      prefix: --nucleotide_variations
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
  - id: proximity
    type:
      - 'null'
      - int
    doc: Minimum proximity between SNPs
    default: 0
    inputBinding:
      position: 101
      prefix: --proximity
  - id: reference
    type:
      - 'null'
      - string
    doc: Target reference
    default: None
    inputBinding:
      position: 101
      prefix: --reference
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
  - id: significance_lvl
    type:
      - 'null'
      - float
    doc: Minimum lvl. of signifiacnce
    default: 0.05
    inputBinding:
      position: 101
      prefix: --significance_lvl
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
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
