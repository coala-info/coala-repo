cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtgbo
label: smartdenovo_wtgbo
doc: "Overlapper based on overlap graph\n\nTool homepage: https://github.com/ruanjue/smartdenovo"
inputs:
  - id: align_penalty_gap_extension
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: gap extension'
    inputBinding:
      position: 101
      prefix: -E
  - id: align_penalty_indel
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: insertion or deletion'
    inputBinding:
      position: 101
      prefix: -O
  - id: align_penalty_match
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: match'
    inputBinding:
      position: 101
      prefix: -M
  - id: align_penalty_mismatch
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: mismatch'
    inputBinding:
      position: 101
      prefix: -X
  - id: align_penalty_read_end_clip
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: read end clipping, 0: distable HSP extension, otherwise
      set to -50 or other'
    inputBinding:
      position: 101
      prefix: -T
  - id: aligned_pairs_file
    type:
      - 'null'
      - File
    doc: "Record pairs of sequences have beed aligned regardless of successful, including
      pairs from '-L', Format: read1\\tread2"
    inputBinding:
      position: 101
      prefix: '-9'
  - id: best_score_cutoff
    type:
      - 'null'
      - float
    doc: Best score cutoff, say best overlap MUST have alignment score >= <-r> *
      read's best score
    inputBinding:
      position: 101
      prefix: -q
  - id: disable_homopolymer_compression
    type:
      - 'null'
      - boolean
    doc: Turn off homopolymer compression
    inputBinding:
      position: 101
      prefix: -H
  - id: filter_high_freq_kmer
    type:
      - 'null'
      - int
    doc: Filter high frequency z-mers, maybe repetitive
    inputBinding:
      position: 101
      prefix: -Z
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite output file
    inputBinding:
      position: 101
      prefix: -f
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Smaller kmer size (z-mer), 5 <= <-z> <= 16
    inputBinding:
      position: 101
      prefix: -z
  - id: load_pairs_file
    type:
      - 'null'
      - File
    doc: Load pairs of read name from file, will avoid to calculate overlap them
      again
    inputBinding:
      position: 101
      prefix: -L
  - id: long_reads_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Long reads sequences file(s)
    inputBinding:
      position: 101
      prefix: -i
  - id: long_reads_retained_region
    type:
      - 'null'
      - string
    doc: 'Long reads retained region, often from wtobt, Format: read_name\toffset\tlength\toriginal_len'
    inputBinding:
      position: 101
      prefix: -b
  - id: max_alignment_margin
    type:
      - 'null'
      - int
    doc: Maximum margin of alignment
    inputBinding:
      position: 101
      prefix: -u
  - id: max_bandwidth
    type:
      - 'null'
      - int
    doc: Maximum bandwidth
    inputBinding:
      position: 101
      prefix: -W
  - id: max_iteration_turns
    type:
      - 'null'
      - int
    doc: Max turns of iteration
    inputBinding:
      position: 101
      prefix: -N
  - id: max_variant_uncompressed_size
    type:
      - 'null'
      - int
    doc: Maximum variant of uncompressed sizes between two matched hz-kmer
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
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score
    inputBinding:
      position: 101
      prefix: -s
  - id: min_bandwidth
    type:
      - 'null'
      - int
    doc: Minimum bandwidth, iteratively doubled to maximum
    inputBinding:
      position: 101
      prefix: -w
  - id: min_estimated_coverage
    type:
      - 'null'
      - int
    doc: Minimum estimated coverage of edge to be trusted, edge coverage is 
      calculated by counting overlaps that can replace this edge
    inputBinding:
      position: 101
      prefix: -c
  - id: min_seeding_region_in_zmer
    type:
      - 'null'
      - int
    doc: Minimum size of seeding region within zmer window
    inputBinding:
      position: 101
      prefix: -R
  - id: min_total_seeding_region
    type:
      - 'null'
      - int
    doc: Minimum size of total seeding region for zmer windows
    inputBinding:
      position: 101
      prefix: -r
  - id: overlap_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Overlap file(s), Format: reads1\t+/-\tlen1\tbeg1\tend1\treads2\t+/-\tlen2\tbeg2\tend2\tscore'
    inputBinding:
      position: 101
      prefix: -j
  - id: refine_alignment
    type:
      - 'null'
      - boolean
    doc: Refine the alignment
    inputBinding:
      position: 101
      prefix: -n
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 101
      prefix: -t
  - id: use_matches_as_score
    type:
      - 'null'
      - boolean
    doc: Use number of matches as alignment score
    inputBinding:
      position: 101
      prefix: -Q
  - id: zmer_window
    type:
      - 'null'
      - int
    doc: Zmer window
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: output_overlaps_file
    type:
      - 'null'
      - File
    doc: Output file of new overlaps
    outputBinding:
      glob: $(inputs.output_overlaps_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
