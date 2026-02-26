cwlVersion: v1.2
class: CommandLineTool
baseCommand: dipper_dipper_cpu
label: dipper_dipper_cpu
doc: "DIPPER Command Line Arguments\n\nTool homepage: https://github.com/TurakhiaLab/DIPPER"
inputs:
  - id: add
    type:
      - 'null'
      - boolean
    doc: Add query to backbone using k-closest placement
    inputBinding:
      position: 101
      prefix: --add
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'Algorithm selection: 0 - default mode, 1 - force placement, 2 - force conventional
      NJ, 3 - force divide-and-conquer'
    inputBinding:
      position: 101
      prefix: --algorithm
  - id: distance_type
    type:
      - 'null'
      - int
    doc: 'Distance type to calculate: 1 - uncorrected, 2 - JC (default), 3 - Tajima-Nei,
      4 - K2P, 5 - Tamura, 6 - Jinnei'
    default: 2
    inputBinding:
      position: 101
      prefix: --distance-type
  - id: input_file
    type: File
    doc: 'Input file path: PHYLIP format for distance matrix, FASTA format for aligned
      or unaligned sequences'
    inputBinding:
      position: 101
      prefix: --input-file
  - id: input_format
    type: string
    doc: 'Input format: d - distance matrix in PHYLIP format, r - unaligned sequences
      in FASTA format, m - aligned sequences in FASTA format'
    inputBinding:
      position: 101
      prefix: --input-format
  - id: input_tree
    type:
      - 'null'
      - File
    doc: Input backbone tree (Newick format), required with --add option
    inputBinding:
      position: 101
      prefix: --input-tree
  - id: k_closest
    type:
      - 'null'
      - int
    doc: 'Placement mode: -1 - exact mode, 10 - default'
    default: 10
    inputBinding:
      position: 101
      prefix: --K-closest
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: 'K-mer size: Valid range: 2-15 (default: 15)'
    default: 15
    inputBinding:
      position: 101
      prefix: --kmer-size
  - id: no_shuffle
    type:
      - 'null'
      - boolean
    doc: Disable random shuffling to ensure deterministic and reproducible 
      results.
    inputBinding:
      position: 101
      prefix: --no-shuffle
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: t - phylogenetic tree in Newick format (default), d - distance
      matrix in PHYLIP format (coming soon)'
    default: t
    inputBinding:
      position: 101
      prefix: --output-format
  - id: sketch_size
    type:
      - 'null'
      - int
    doc: 'Sketch size (default: 1000)'
    default: 1000
    inputBinding:
      position: 101
      prefix: --sketch-size
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of CPU threads. Default: all available threads.'
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_file
    type: File
    doc: Output file path
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dipper:0.1.3--h6bb9b41_0
