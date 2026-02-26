cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pairtools
  - scaling
label: pairtools_scaling
doc: "Calculate pairs scalings.\n\nTool homepage: https://github.com/mirnylab/pairtools"
inputs:
  - id: input_paths
    type:
      - 'null'
      - type: array
        items: File
    doc: "by default, a .pairs/.pairsam file to calculate statistics. If\n  not provided,
      the input is read from stdin."
    inputBinding:
      position: 1
  - id: chunksize
    type:
      - 'null'
      - int
    doc: "Number of pairs in each chunk. Reduce for\n                            \
      \      lower memory footprint."
    default: 100000
    inputBinding:
      position: 102
  - id: cmd_in
    type:
      - 'null'
      - string
    doc: "A command to decompress the input file. If\n                           \
      \       provided, fully overrides the auto-guessed\n                       \
      \           command. Does not work with stdin and\n                        \
      \          pairtools parse. Must read input from stdin\n                   \
      \               and print output into stdout. EXAMPLE:\n                   \
      \               pbgzip -dc -n 3"
    inputBinding:
      position: 102
  - id: cmd_out
    type:
      - 'null'
      - string
    doc: "A command to compress the output file. If\n                            \
      \      provided, fully overrides the auto-guessed\n                        \
      \          command. Does not work with stdout. Must\n                      \
      \            read input from stdin and print output into\n                 \
      \                 stdout. EXAMPLE: pbgzip -c -n 8"
    inputBinding:
      position: 102
  - id: dist_range
    type:
      - 'null'
      - type: array
        items: int
    doc: Distance range.
    default:
      - 1
      - 1000000000
    inputBinding:
      position: 102
  - id: n_dist_bins_decade
    type:
      - 'null'
      - int
    doc: "Number of bins to split the distance range\n                           \
      \       in log10-space, specified per a factor of 10\n                     \
      \             difference."
    default: 8
    inputBinding:
      position: 102
  - id: nproc_in
    type:
      - 'null'
      - int
    doc: "Number of processes used by the auto-guessed\n                         \
      \         input decompressing command."
    default: 3
    inputBinding:
      position: 102
  - id: nproc_out
    type:
      - 'null'
      - int
    doc: "Number of processes used by the auto-guessed\n                         \
      \         output compressing command."
    default: 8
    inputBinding:
      position: 102
  - id: regions_file
    type:
      - 'null'
      - File
    doc: "Path to a BED file which defines which\n                               \
      \   regions (viewframe) of the chromosomes to\n                            \
      \      use. By default, this is parsed from .pairs\n                       \
      \           header."
    inputBinding:
      position: 102
      prefix: --view
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output .tsv file with summary.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pairtools:1.1.3--py310h4e61836_0
