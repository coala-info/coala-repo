cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtcns
label: smartdenovo_wtcns
doc: "Consensus caller\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: align_reads_output_file
    type:
      - 'null'
      - string
    doc: Align reads against final consensus, and output to <-a>
    inputBinding:
      position: 101
      prefix: -a
  - id: alignment_penalty_deletion_after_first
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: deletion, used in rounds after first'
    inputBinding:
      position: 101
      prefix: -D
  - id: alignment_penalty_gap_extension
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: gap extension'
    inputBinding:
      position: 101
      prefix: -E
  - id: alignment_penalty_indel_first_round
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: insertion or deletion, used in first round'
    inputBinding:
      position: 101
      prefix: -O
  - id: alignment_penalty_insertion_after_first
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: insertion, used in rounds after first'
    inputBinding:
      position: 101
      prefix: -I
  - id: alignment_penalty_match
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: match'
    inputBinding:
      position: 101
      prefix: -M
  - id: alignment_penalty_mismatch
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: mismatch'
    inputBinding:
      position: 101
      prefix: -X
  - id: alignment_penalty_read_end_clipping
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: read end clipping'
    inputBinding:
      position: 101
      prefix: -T
  - id: basic_bandwidth_refine_alignment
    type:
      - 'null'
      - int
    doc: Basic bandwidth in refine-alignment
    inputBinding:
      position: 101
      prefix: -r
  - id: consensus_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations for consensus calling, the larger, the accurater, 
      the slower
    inputBinding:
      position: 101
      prefix: -n
  - id: current_job_index
    type:
      - 'null'
      - int
    doc: Index of current job (0-based)
    inputBinding:
      position: 101
      prefix: -p
  - id: disable_fast_zmer_align
    type:
      - 'null'
      - boolean
    doc: Disable fast zmer align in final aligning (see -a), use standard 
      smith-waterman
    inputBinding:
      position: 101
      prefix: -A
  - id: disable_phredqv_refine_alignment
    type:
      - 'null'
      - boolean
    doc: Disable PhreadQV in refine-alignment
    inputBinding:
      position: 101
      prefix: -F
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 101
      prefix: -f
  - id: homopolymer_compression
    type:
      - 'null'
      - boolean
    doc: Trun on homopolymer compression
    inputBinding:
      position: 101
      prefix: -H
  - id: input_file
    type: string
    doc: Input file, layout from wtlay
    inputBinding:
      position: 101
      prefix: -i
  - id: max_bandwidth
    type:
      - 'null'
      - int
    doc: Maximum bandwidth
    inputBinding:
      position: 101
      prefix: -W
  - id: max_bandwidth_ending_extension
    type:
      - 'null'
      - int
    doc: Maximum bandwidth at ending extension
    inputBinding:
      position: 101
      prefix: -e
  - id: max_variant_uncompressed_size
    type:
      - 'null'
      - int
    doc: Maximum variant of uncompressed sizes between two matched zmer
    inputBinding:
      position: 101
      prefix: -l
  - id: min_alignment_identity
    type:
      - 'null'
      - float
    doc: Minimum alignment identity
    inputBinding:
      position: 101
      prefix: -m
  - id: min_bandwidth
    type:
      - 'null'
      - int
    doc: Minimum bandwidth, iteratively doubled to maximum
    inputBinding:
      position: 101
      prefix: -w
  - id: min_seeding_region_size
    type:
      - 'null'
      - int
    doc: Minimum size of seeding region within zmer window
    inputBinding:
      position: 101
      prefix: -R
  - id: output_variants_and_print
    type:
      - 'null'
      - float
    doc: 'Ouput call variants and print to <-a>, -V 2.05 mean: min_allele_count>=2,min_allele_freq>=0.05'
    inputBinding:
      position: 101
      prefix: -V
  - id: penalty_alternative_edge
    type:
      - 'null'
      - float
    doc: Penalty of alternative edge in calling consensus
    inputBinding:
      position: 101
      prefix: -N
  - id: penalty_backbone_edge
    type:
      - 'null'
      - float
    doc: Penalty of backbone edge in calling consensus
    inputBinding:
      position: 101
      prefix: -Y
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: total_parallel_jobs
    type:
      - 'null'
      - int
    doc: Total parallel jobs
    inputBinding:
      position: 101
      prefix: -P
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose, BE careful, HUGEEEEEEEE output on STDOUT
    inputBinding:
      position: 101
      prefix: -v
  - id: zmer_size
    type:
      - 'null'
      - int
    doc: Zmer size, 5 <= <-z> <= 16
    inputBinding:
      position: 101
      prefix: -z
  - id: zmer_window
    type:
      - 'null'
      - int
    doc: Zmer window
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file, consensus sequences
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
