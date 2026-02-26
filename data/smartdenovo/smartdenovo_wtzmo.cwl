cwlVersion: v1.2
class: CommandLineTool
baseCommand: wtzmo
label: smartdenovo_wtzmo
doc: "Overlaper of long reads using homopolymer compressed k-mer seeding\n\nTool homepage:
  https://github.com/ruanjue/smartdenovo"
inputs:
  - id: alignment_penalty_gap_extension
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: gap extension'
    default: -1
    inputBinding:
      position: 101
      prefix: -E
  - id: alignment_penalty_indel
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: insertion or deletion'
    default: -3
    inputBinding:
      position: 101
      prefix: -O
  - id: alignment_penalty_match
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: match'
    default: 2
    inputBinding:
      position: 101
      prefix: -M
  - id: alignment_penalty_mismatch
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: mismatch'
    default: -5
    inputBinding:
      position: 101
      prefix: -X
  - id: alignment_penalty_read_end_clipping
    type:
      - 'null'
      - int
    doc: 'Alignment penalty: read end clipping, 0: distable HSP extension, otherwise
      set to -50 or other'
    default: -50
    inputBinding:
      position: 101
      prefix: -T
  - id: build_kmer_index_iterations
    type:
      - 'null'
      - int
    doc: Build kmer index in multiple iterations to save memory
    default: 1
    inputBinding:
      position: 101
      prefix: -G
  - id: current_job_index
    type:
      - 'null'
      - int
    doc: Index of current job (0-based)
    default: 0
    inputBinding:
      position: 101
      prefix: -p
  - id: exclude_reads_file
    type:
      - 'null'
      - File
    doc: Reads from this file(s) are to be exclued, one line for one read name
    default: 'NULL'
    inputBinding:
      position: 101
      prefix: -F
  - id: filter_high_frequency_kmers
    type:
      - 'null'
      - int
    doc: Filter high frequency kmers, maybe repetitive
    default: 0
    inputBinding:
      position: 101
      prefix: -K
  - id: filter_high_frequency_zmers
    type:
      - 'null'
      - int
    doc: Filter high frequency z-mers, maybe repetitive
    default: 64
    inputBinding:
      position: 101
      prefix: -Z
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Force overwrite
    inputBinding:
      position: 101
      prefix: -f
  - id: homopolymer_compression_option
    type:
      - 'null'
      - int
    doc: Option of homopolymer compression
    default: 3
    inputBinding:
      position: 101
      prefix: -H
  - id: jack_knife_original_read_length
    type:
      - 'null'
      - int
    doc: Jack knife of original read length
    default: 0
    inputBinding:
      position: 101
      prefix: -J
  - id: kmer_size
    type:
      - 'null'
      - int
    doc: Kmer size, 5 <= <-k> <= 32
    default: 16
    inputBinding:
      position: 101
      prefix: -k
  - id: limit_best_candidates
    type:
      - 'null'
      - int
    doc: Limit number of best candidates per read
    default: 500
    inputBinding:
      position: 101
      prefix: -A
  - id: limit_best_overlaps
    type:
      - 'null'
      - int
    doc: Limit number of best overlaps per read
    default: 100
    inputBinding:
      position: 101
      prefix: -B
  - id: load_pairs_file
    type:
      - 'null'
      - File
    doc: Load pairs of read name from file, will avoid to calculate overlap them
      again
    default: 'NULL'
    inputBinding:
      position: 101
      prefix: -L
  - id: long_reads_file
    type: File
    doc: Long reads sequences file
    inputBinding:
      position: 101
      prefix: -i
  - id: long_reads_no_index
    type:
      - 'null'
      - File
    doc: Long reads sequence file, DON'T build index on them. If specified, 
      program will only align them against all sequences from <-i>
    inputBinding:
      position: 101
      prefix: -I
  - id: max_bandwidth
    type:
      - 'null'
      - int
    doc: Maximum bandwidth
    default: 3200
    inputBinding:
      position: 101
      prefix: -W
  - id: max_bandwidth_ending_extension
    type:
      - 'null'
      - int
    doc: Maximum bandwidth at ending extension
    default: 800
    inputBinding:
      position: 101
      prefix: -e
  - id: max_variant_uncompressed_sizes
    type:
      - 'null'
      - int
    doc: Maximum variant of uncompressed sizes between two matched hz-kmer
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
  - id: min_alignment_score
    type:
      - 'null'
      - int
    doc: Minimum alignment score
    default: 200
    inputBinding:
      position: 101
      prefix: -s
  - id: min_bandwidth
    type:
      - 'null'
      - int
    doc: Minimum bandwidth, iteratively doubled to maximum
    default: 50
    inputBinding:
      position: 101
      prefix: -w
  - id: min_seeding_region_zmer
    type:
      - 'null'
      - int
    doc: Minimum size of seeding region within zmer window
    default: 200
    inputBinding:
      position: 101
      prefix: -R
  - id: min_total_seeding_region_kmer
    type:
      - 'null'
      - int
    doc: Minimum size of total seeding region for kmer windows
    default: 300
    inputBinding:
      position: 101
      prefix: -d
  - id: min_total_seeding_region_zmer
    type:
      - 'null'
      - int
    doc: Minimum size of total seeding region for zmer windows
    default: 300
    inputBinding:
      position: 101
      prefix: -r
  - id: record_aligned_pairs_file
    type:
      - 'null'
      - File
    doc: Record pairs of sequences have beed aligned regardless of successful, 
      including pairs from '-L'
    inputBinding:
      position: 101
      prefix: '-9'
  - id: refine_alignment
    type:
      - 'null'
      - boolean
    doc: Refine the alignment
    inputBinding:
      position: 101
      prefix: -n
  - id: retained_region_file
    type:
      - 'null'
      - File
    doc: Long reads retained region, often from wtobt/wtcyc
    inputBinding:
      position: 101
      prefix: -b
  - id: skip_contained_overlaps
    type:
      - 'null'
      - boolean
    doc: Don't skip calculation of its overlaps even when the read was contained
      by others
    inputBinding:
      position: 101
      prefix: -C
  - id: subsampling_kmers
    type:
      - 'null'
      - int
    doc: Subsampling kmers, 1/<-S> kmers are indexed
    default: 4
    inputBinding:
      position: 101
      prefix: -S
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 1
    inputBinding:
      position: 101
      prefix: -t
  - id: threshold_seed_window_coverage
    type:
      - 'null'
      - int
    doc: THreshold of seed-window coverage along query, will be used to decrease
      weight of repetitive region
    default: 100
    inputBinding:
      position: 101
      prefix: -q
  - id: total_parallel_jobs
    type:
      - 'null'
      - int
    doc: Total parallel jobs
    default: 1
    inputBinding:
      position: 101
      prefix: -P
  - id: ultra_fast_dot_matrix_alignment
    type:
      - 'null'
      - type: array
        items: float
    doc: Ultra-fast dot matrix alignment, pattern search in zmer image
    inputBinding:
      position: 101
      prefix: -U
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
    doc: Smaller kmer size (z-mer), 5 <= <-z> <= 16
    default: 10
    inputBinding:
      position: 101
      prefix: -z
  - id: zmer_window_size
    type:
      - 'null'
      - int
    doc: Zmer window
    default: 800
    inputBinding:
      position: 101
      prefix: -y
outputs:
  - id: output_alignments_file
    type: File
    doc: Output file of alignments
    outputBinding:
      glob: $(inputs.output_alignments_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smartdenovo:1.0.0--h7b50bb2_8
