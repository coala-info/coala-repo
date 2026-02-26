cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtmsa
label: smartdenovo_wtmsa
doc: "Consensus caller using POA\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: alignment_deletion_penalty
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: deletion'
    default: -3
    inputBinding:
      position: 101
      prefix: -D
  - id: alignment_gap_extension_penalty
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: gap extension'
    default: -1
    inputBinding:
      position: 101
      prefix: -E
  - id: alignment_insertion_penalty
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: insertion'
    default: -2
    inputBinding:
      position: 101
      prefix: -I
  - id: alignment_match_penalty
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: match'
    default: 2
    inputBinding:
      position: 101
      prefix: -M
  - id: alignment_mismatch_penalty
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: mismatch'
    default: -5
    inputBinding:
      position: 101
      prefix: -X
  - id: alignment_read_end_clipping_penalty
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: read end clipping'
    default: -10
    inputBinding:
      position: 101
      prefix: -T
  - id: basic_graph_alignment_bandwidth
    type:
      - 'null'
      - int
    doc: Basic bandwidth in graph alignment
    default: 100
    inputBinding:
      position: 101
      prefix: -g
  - id: consensus_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for consensus calling, the more, the accurater, 
      the slower
    default: 2
    inputBinding:
      position: 101
      prefix: -n
  - id: current_job_index
    type:
      - 'null'
      - int
    doc: Index of current job (0-based)
    default: 0
    inputBinding:
      position: 101
      prefix: -p
  - id: disable_homopolymer_compression
    type:
      - 'null'
      - boolean
    doc: Trun off homopolymer compression
    inputBinding:
      position: 101
      prefix: -H
  - id: disable_phredqv_refine_alignment
    type:
      - 'null'
      - boolean
    doc: Disable PhreadQV in refine-alignment
    inputBinding:
      position: 101
      prefix: -F
  - id: enable_homopolymer_merge_penalty
    type:
      - 'null'
      - boolean
    doc: turn on homopolymer merge penalty
    inputBinding:
      position: 101
      prefix: -V
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 101
      prefix: -f
  - id: input_file
    type: string
    doc: Input file, layout from wtlay, +, *
    inputBinding:
      position: 101
      prefix: -i
  - id: max_graph_alignment_ending_extension_bandwidth
    type:
      - 'null'
      - int
    doc: Maximum bandwidth at graph alignment and ending extension
    default: 800
    inputBinding:
      position: 101
      prefix: -e
  - id: max_pairwise_alignment_bandwidth
    type:
      - 'null'
      - int
    doc: Maximum bandwidth of pairwise alignment
    default: 3200
    inputBinding:
      position: 101
      prefix: -W
  - id: max_uncompressed_variant
    type:
      - 'null'
      - int
    doc: Maximum variant of uncompressed sizes between two matched zmer
    default: 2
    inputBinding:
      position: 101
      prefix: -l
  - id: min_alignment_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity
    default: 0.5
    inputBinding:
      position: 101
      prefix: -m
  - id: min_pairwise_alignment_bandwidth
    type:
      - 'null'
      - int
    doc: Minimum bandwidth of pairwise alignment, iteratively doubled to maximum
    default: 50
    inputBinding:
      position: 101
      prefix: -w
  - id: min_seeding_region_size
    type:
      - 'null'
      - int
    doc: Minimum size of seeding region within zmer window
    default: 200
    inputBinding:
      position: 101
      prefix: -R
  - id: parallel_jobs
    type:
      - 'null'
      - int
    doc: Total parallel jobs
    default: 1
    inputBinding:
      position: 101
      prefix: -P
  - id: print_backbone_sequences
    type:
      - 'null'
      - string
    doc: Print backbone sequences on file for debug
    default: 'NULL'
    inputBinding:
      position: 101
      prefix: -B
  - id: print_dot_graph
    type:
      - 'null'
      - string
    doc: Print dot graph on file, H U G E, be careful
    default: 'NULL'
    inputBinding:
      position: 101
      prefix: -G
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 101
      prefix: -v
  - id: zmer_size
    type:
      - 'null'
      - int
    doc: Zmer size, 5 <= <-z> <= 16
    default: 10
    inputBinding:
      position: 101
      prefix: -z
  - id: zmer_window
    type:
      - 'null'
      - int
    doc: Zmer window
    default: 800
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: output_file
    type: File
    doc: Output file, consensus sequences, *
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
