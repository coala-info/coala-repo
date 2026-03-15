cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - diamond
  - recluster
label: diamond_recluster
doc: Recluster sequences using the DIAMOND algorithm
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: number of CPU threads
    inputBinding:
      position: 101
      prefix: --threads
  - id: log
    type:
      - 'null'
      - boolean
    doc: enable debug log
    inputBinding:
      position: 101
      prefix: --log
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: disable console output
    inputBinding:
      position: 101
      prefix: --quiet
  - id: tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files
    inputBinding:
      position: 101
      prefix: --tmpdir
  - id: db
    type: File
    doc: database file
    inputBinding:
      position: 101
      prefix: --db
  - id: out
    type: string
    doc: output file
    inputBinding:
      position: 101
      prefix: --out
  - id: header
    type:
      - 'null'
      - string
    doc: Use header lines in tabular output format (0/simple/verbose).
    inputBinding:
      position: 101
      prefix: --header
  - id: comp_based_stats
    type:
      - 'null'
      - int
    doc: composition based statistics mode (0-4)
    inputBinding:
      position: 101
      prefix: --comp-based-stats
  - id: masking
    type:
      - 'null'
      - string
    doc: masking algorithm (none, seg, tantan=default)
    inputBinding:
      position: 101
      prefix: --masking
  - id: soft_masking
    type:
      - 'null'
      - string
    doc: soft masking (none=default, seg, tantan)
    inputBinding:
      position: 101
      prefix: --soft-masking
  - id: gapopen
    type:
      - 'null'
      - int
    doc: gap open penalty
    inputBinding:
      position: 101
      prefix: --gapopen
  - id: gapextend
    type:
      - 'null'
      - int
    doc: gap extension penalty
    inputBinding:
      position: 101
      prefix: --gapextend
  - id: matrix
    type:
      - 'null'
      - string
    doc: score matrix for protein alignment
    inputBinding:
      position: 101
      prefix: --matrix
  - id: custom_matrix
    type:
      - 'null'
      - File
    doc: file containing custom scoring matrix
    inputBinding:
      position: 101
      prefix: --custom-matrix
  - id: evalue
    type:
      - 'null'
      - float
    doc: maximum e-value to report alignments
    inputBinding:
      position: 101
      prefix: --evalue
  - id: motif_masking
    type:
      - 'null'
      - int
    doc: softmask abundant motifs (0/1)
    inputBinding:
      position: 101
      prefix: --motif-masking
  - id: approx_id
    type:
      - 'null'
      - float
    doc: minimum approx. identity% to report an alignment/to cluster sequences
    inputBinding:
      position: 101
      prefix: --approx-id
  - id: ext
    type:
      - 'null'
      - string
    doc: Extension mode (banded-fast/banded-slow/full)
    inputBinding:
      position: 101
      prefix: --ext
  - id: cluster_steps
    type:
      - 'null'
      - string
    doc: Clustering steps
    inputBinding:
      position: 101
      prefix: --cluster-steps
  - id: kmer_ranking
    type:
      - 'null'
      - boolean
    doc: Rank sequences based on kmer frequency in linear stage
    inputBinding:
      position: 101
      prefix: --kmer-ranking
  - id: round_coverage
    type:
      - 'null'
      - string
    doc: Per-round coverage cutoffs for cascaded clustering
    inputBinding:
      position: 101
      prefix: --round-coverage
  - id: round_approx_id
    type:
      - 'null'
      - string
    doc: Per-round approx-id cutoffs for cascaded clustering
    inputBinding:
      position: 101
      prefix: --round-approx-id
  - id: aln_out
    type: string
    doc: Output file for clustering alignments
    inputBinding:
      position: 101
      prefix: --aln-out
  - id: memory_limit
    type:
      - 'null'
      - string
    doc: Memory limit in GB
    inputBinding:
      position: 101
      prefix: --memory-limit
  - id: member_cover
    type:
      - 'null'
      - float
    doc: Minimum coverage% of the cluster member sequence
    inputBinding:
      position: 101
      prefix: --member-cover
  - id: mutual_cover
    type:
      - 'null'
      - float
    doc: Minimum mutual coverage% of the cluster member and representative 
      sequence
    inputBinding:
      position: 101
      prefix: --mutual-cover
  - id: connected_component_depth
    type:
      - 'null'
      - int
    doc: Depth to cluster connected components
    inputBinding:
      position: 101
      prefix: --connected-component-depth
  - id: no_reassign
    type:
      - 'null'
      - boolean
    doc: Do not reassign to closest representative
    inputBinding:
      position: 101
      prefix: --no-reassign
  - id: clusters
    type:
      - 'null'
      - File
    doc: Clustering input file mapping sequences to representatives
    inputBinding:
      position: 101
      prefix: --clusters
  - id: parallel_tmpdir
    type:
      - 'null'
      - Directory
    doc: directory for temporary files used by multiprocessing
    inputBinding:
      position: 101
      prefix: --parallel-tmpdir
  - id: bin
    type:
      - 'null'
      - int
    doc: number of query bins for seed search
    inputBinding:
      position: 101
      prefix: --bin
  - id: ext_chunk_size
    type:
      - 'null'
      - string
    doc: chunk size for adaptive ranking
    inputBinding:
      position: 101
      prefix: --ext-chunk-size
  - id: no_ranking
    type:
      - 'null'
      - boolean
    doc: disable ranking heuristic
    inputBinding:
      position: 101
      prefix: --no-ranking
  - id: dbsize
    type:
      - 'null'
      - int
    doc: effective database size (in letters)
    inputBinding:
      position: 101
      prefix: --dbsize
  - id: no_auto_append
    type:
      - 'null'
      - boolean
    doc: disable auto appending of DAA and DMND file extensions
    inputBinding:
      position: 101
      prefix: --no-auto-append
  - id: tantan_min_mask_prob
    type:
      - 'null'
      - float
    doc: minimum repeat probability for masking
    inputBinding:
      position: 101
      prefix: --tantan-minMaskProb
  - id: oid_output
    type:
      - 'null'
      - boolean
    doc: Output OIDs instead of accessions (clustering)
    inputBinding:
      position: 101
      prefix: --oid-output
  - id: swipe_task_size
    type:
      - 'null'
      - int
    doc: task size for DP parallelism
    inputBinding:
      position: 101
      prefix: --swipe-task-size
  - id: anchored_swipe
    type:
      - 'null'
      - boolean
    doc: Enable anchored SWIPE extension
    inputBinding:
      position: 101
      prefix: --anchored-swipe
  - id: query_match_distance_threshold
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --query-match-distance-threshold
  - id: length_ratio_threshold
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --length-ratio-threshold
  - id: cbs_angle
    type:
      - 'null'
      - float
    doc: Matrix adjust threshold
    inputBinding:
      position: 101
      prefix: --cbs-angle
  - id: linclust_banded_ext
    type:
      - 'null'
      - boolean
    doc: Use banded instead of full matrix DP for linear searches
    inputBinding:
      position: 101
      prefix: --linclust-banded-ext
  - id: linclust_chunk_size
    type:
      - 'null'
      - string
    doc: Chunk size for linclust in parallel mode
    inputBinding:
      position: 101
      prefix: --linclust-chunk-size
  - id: hit_membuf
    type:
      - 'null'
      - boolean
    doc: Buffer intermediate hits in memory
    inputBinding:
      position: 101
      prefix: --hit-membuf
outputs:
  - id: output_out
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.out)
  - id: output_aln_out
    type:
      - 'null'
      - File
    doc: Output file for clustering alignments
    outputBinding:
      glob: $(inputs.aln_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diamond:2.1.24--hf93d47f_0
s:url: https://github.com/bbuchfink/diamond
$namespaces:
  s: https://schema.org/
