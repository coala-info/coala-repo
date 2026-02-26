cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt
label: fermi_ropebwt
doc: "Compresses DNA sequences using the Burrows-Wheeler Transform.\n\nTool homepage:
  https://github.com/quantumlib/OpenFermion"
inputs:
  - id: input_file
    type: File
    doc: Input gzipped FASTQ file
    inputBinding:
      position: 1
  - id: algorithm
    type:
      - 'null'
      - string
    doc: 'algorithm: bpr or bcr'
    default: bpr
    inputBinding:
      position: 102
      prefix: -a
  - id: binary_output
    type:
      - 'null'
      - boolean
    doc: binary output (5+3 runs starting after 4 bytes)
    inputBinding:
      position: 102
      prefix: -b
  - id: cut_at_ambiguous_bases
    type:
      - 'null'
      - boolean
    doc: cut at ambiguous bases
    inputBinding:
      position: 102
      prefix: -N
  - id: enable_threading
    type:
      - 'null'
      - boolean
    doc: enable threading (bcr only)
    inputBinding:
      position: 102
      prefix: -t
  - id: max_children_per_internal_node
    type:
      - 'null'
      - int
    doc: max number children per internal node (bpr only)
    default: 64
    inputBinding:
      position: 102
      prefix: -n
  - id: max_runs_in_leaves
    type:
      - 'null'
      - int
    doc: max number of runs in leaves (bpr only)
    default: 512
    inputBinding:
      position: 102
      prefix: -r
  - id: print_tree_stdout
    type:
      - 'null'
      - boolean
    doc: print the tree stdout (bpr only)
    inputBinding:
      position: 102
      prefix: -T
  - id: skip_forward_strand
    type:
      - 'null'
      - boolean
    doc: skip forward strand
    inputBinding:
      position: 102
      prefix: -F
  - id: skip_reverse_strand
    type:
      - 'null'
      - boolean
    doc: skip reverse strand
    inputBinding:
      position: 102
      prefix: -R
  - id: suppress_end_trimming
    type:
      - 'null'
      - boolean
    doc: suppress end trimming when forward==reverse
    inputBinding:
      position: 102
      prefix: -O
  - id: temporary_sequence_file
    type:
      - 'null'
      - File
    doc: temporary sequence file name (bcr only)
    default: 'null'
    inputBinding:
      position: 102
      prefix: -f
  - id: verbose_level
    type:
      - 'null'
      - int
    doc: verbose level (bcr only)
    default: 2
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi:1.1_r751_beta--h577a1d6_9
