cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - cluster
label: diamond_cluster
doc: "Clustering sequences using DIAMOND\n\nTool homepage: https://github.com/bbuchfink/diamond"
inputs:
  - id: anchored_swipe
    type:
      - 'null'
      - boolean
    doc: Enable anchored SWIPE extension
    inputBinding:
      position: 101
      prefix: --anchored-swipe
  - id: approx_id
    type:
      - 'null'
      - float
    doc: minimum approx. identity% to report an alignment/to cluster sequences
    inputBinding:
      position: 101
      prefix: --approx-id
  - id: bin
    type:
      - 'null'
      - int
    doc: number of query bins for seed search
    inputBinding:
      position: 101
      prefix: --bin
  - id: cbs_angle
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --cbs-angle
  - id: cluster_steps
    type:
      - 'null'
      - string
    doc: Clustering steps
    inputBinding:
      position: 101
      prefix: --cluster-steps
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: connected_component_depth
    type:
      - 'null'
      - int
    doc: Depth to cluster connected components
    inputBinding:
      position: 101
      prefix: --connected-component-depth
  - id: db
    type:
      - 'null'
      - File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: dbsize
    type:
      - 'null'
      - int
    doc: effective database size (in letters)
    inputBinding:
      position: 101
      prefix: --dbsize
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments (default=0.001)
    default: 0.001
    inputBinding:
      position: 101
      prefix: --evalue
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension mode (banded-fast/banded-slow/full)
    inputBinding:
      position: 101
      prefix: --ext
  - id: ext_chunk_size
    type:
      - 'null'
      - string
    doc: chunk size for adaptive ranking (default=auto)
    default: auto
    inputBinding:
      position: 101
      prefix: --ext-chunk-size
  - id: file_buffer_size
    type:
      - 'null'
      - int
    doc: file buffer size in bytes (default=67108864)
    default: 67108864
    inputBinding:
      position: 101
      prefix: --file-buffer-size
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: hit_membuf
    type:
      - 'null'
      - int
    doc: Buffer intermediate hits in memory (0=default/1)
    default: 0
    inputBinding:
      position: 101
      prefix: --hit-membuf
  - id: ignore_warnings
    type:
      - 'null'
      - boolean
    doc: Ignore warnings
    inputBinding:
      position: 101
      prefix: --ignore-warnings
  - id: kmer_ranking
    type:
      - 'null'
      - boolean
    doc: Rank sequences based on kmer frequency in linear stage
    inputBinding:
      position: 101
      prefix: --kmer-ranking
  - id: length_ratio_threshold
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --length-ratio-threshold
  - id: linclust_banded_ext
    type:
      - 'null'
      - boolean
    doc: Use banded instead of full matrix DP for linear searches
    inputBinding:
      position: 101
      prefix: --linclust-banded-ext
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    inputBinding:
      position: 101
      prefix: --masking
  - id: member_cover
    type:
      - 'null'
      - float
    doc: Minimum coverage% of the cluster member sequence (default=80.0)
    default: 80.0
    inputBinding:
      position: 101
      prefix: --member-cover
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: Memory limit in GB (default = 16G)
    default: 16G
    inputBinding:
      position: 101
      prefix: --memory-limit
  - id: motif_masking
    type:
      - 'null'
      - int
    doc: softmask abundant motifs (0/1)
    inputBinding:
      position: 101
      prefix: --motif-masking
  - id: mutual_cover
    type:
      - 'null'
      - float
    doc: Minimum mutual coverage% of the cluster member and representative 
      sequence
    inputBinding:
      position: 101
      prefix: --mutual-cover
  - id: no_auto_append
    type:
      - 'null'
      - boolean
    doc: disable auto appending of DAA and DMND file extensions
    inputBinding:
      position: 101
      prefix: --no-auto-append
  - id: no_parse_seqids
    type:
      - 'null'
      - boolean
    doc: Print raw seqids without parsing
    inputBinding:
      position: 101
      prefix: --no-parse-seqids
  - id: no_ranking
    type:
      - 'null'
      - boolean
    doc: disable ranking heuristic
    inputBinding:
      position: 101
      prefix: --no-ranking
  - id: no_reassign
    type:
      - 'null'
      - boolean
    doc: Do not reassign to closest representative
    inputBinding:
      position: 101
      prefix: --no-reassign
  - id: no_unlink
    type:
      - 'null'
      - boolean
    doc: Do not unlink temporary files.
    inputBinding:
      position: 101
      prefix: --no-unlink
  - id: oid_output
    type:
      - 'null'
      - boolean
    doc: Output OIDs instead of accessions (clustering)
    inputBinding:
      position: 101
      prefix: --oid-output
  - id: parallel_tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files used by multiprocessing
    inputBinding:
      position: 101
      prefix: --parallel-tmpdir
  - id: query_match_distance_threshold
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --query-match-distance-threshold
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: round_approx_id
    type:
      - 'null'
      - string
    doc: Per-round approx-id cutoffs for cascaded clustering
    inputBinding:
      position: 101
      prefix: --round-approx-id
  - id: round_coverage
    type:
      - 'null'
      - string
    doc: Per-round coverage cutoffs for cascaded clustering
    inputBinding:
      position: 101
      prefix: --round-coverage
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: swipe_task_size
    type:
      - 'null'
      - int
    doc: task size for DP parallelism (100000000)
    default: 100000000
    inputBinding:
      position: 101
      prefix: --swipe-task-size
  - id: tantan_min_mask_prob
    type:
      - 'null'
      - float
    doc: minimum repeat probability for masking (default=0.9)
    default: 0.9
    inputBinding:
      position: 101
      prefix: --tantan-minMaskProb
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: verbose console output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.21--h13889ed_0
