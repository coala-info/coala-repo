cwlVersion: v1.2
class: CommandLineTool
baseCommand: impg similarity
label: impg_similarity
doc: "Compute pairwise similarity between sequences in a region\n\nTool homepage:
  https://github.com/pangenome/impg"
inputs:
  - id: all
    type:
      - 'null'
      - boolean
    doc: Emit entries for all pairs of groups, including those with zero 
      intersection
    inputBinding:
      position: 101
      prefix: --all
  - id: delim
    type:
      - 'null'
      - string
    doc: The part of each path name before this delimiter is a group identifier
    inputBinding:
      position: 101
      prefix: --delim
  - id: delim_pos
    type:
      - 'null'
      - int
    doc: 'Consider the N-th occurrence of the delimiter (1-indexed, default: 1)'
    default: 1
    inputBinding:
      position: 101
      prefix: --delim-pos
  - id: distances
    type:
      - 'null'
      - boolean
    doc: Output distances instead of similarities
    inputBinding:
      position: 101
      prefix: --distances
  - id: force_large_region
    type:
      - 'null'
      - boolean
    doc: Force processing of large regions (>10kbp) with maf/gfa output formats
    inputBinding:
      position: 101
      prefix: --force-large-region
  - id: force_reindex
    type:
      - 'null'
      - boolean
    doc: Force the regeneration of the index, even if it already exists
    inputBinding:
      position: 101
      prefix: --force-reindex
  - id: index
    type:
      - 'null'
      - File
    doc: Path to the IMPG index file
    inputBinding:
      position: 101
      prefix: --index
  - id: max_depth
    type:
      - 'null'
      - int
    doc: Maximum recursion depth for transitive overlaps (0 for no limit)
    default: 0
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between regions to merge
    default: 0
    inputBinding:
      position: 101
      prefix: --merge-distance
  - id: min_distance_between_ranges
    type:
      - 'null'
      - int
    doc: Minimum distance between transitive ranges to consider on the same 
      sequence
    default: 10
    inputBinding:
      position: 101
      prefix: --min-distance-between-ranges
  - id: min_identity
    type:
      - 'null'
      - float
    doc: Minimum gap-compressed identity threshold (0.0-1.0)
    inputBinding:
      position: 101
      prefix: --min-identity
  - id: min_transitive_len
    type:
      - 'null'
      - int
    doc: Minimum region size to consider for transitive queries
    default: 10
    inputBinding:
      position: 101
      prefix: --min-transitive-len
  - id: no_merge
    type:
      - 'null'
      - boolean
    doc: Disable merging for all output formats
    inputBinding:
      position: 101
      prefix: --no-merge
  - id: original_sequence_coordinates
    type:
      - 'null'
      - boolean
    doc: Update coordinates to original sequences when input sequences are 
      subsequences (seq_name:start-end) for 'bed', 'bedpe', and 'paf'
    inputBinding:
      position: 101
      prefix: --original-sequence-coordinates
  - id: paf_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Path to the PAF files
    inputBinding:
      position: 101
      prefix: --paf-files
  - id: paf_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing paths to PAF files (one per line)
    inputBinding:
      position: 101
      prefix: --paf-list
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Perform PCA/MDS dimensionality reduction on the distance matrix
    inputBinding:
      position: 101
      prefix: --pca
  - id: pca_components
    type:
      - 'null'
      - int
    doc: 'Number of PCA components to output (default: 2)'
    default: 2
    inputBinding:
      position: 101
      prefix: --pca-components
  - id: pca_measure
    type:
      - 'null'
      - string
    doc: Similarity measure to use for PCA distance matrix ("jaccard", "cosine",
      or "dice")
    default: jaccard
    inputBinding:
      position: 101
      prefix: --pca-measure
  - id: poa_scoring
    type:
      - 'null'
      - string
    doc: POA alignment scores as 
      match,mismatch,gap_open1,gap_extend1,gap_open2,gap_extend2 (for 'gfa' and 
      'maf')
    default: 1,4,6,2,26,1
    inputBinding:
      position: 101
      prefix: --poa-scoring
  - id: polarize_guide_samples
    type:
      - 'null'
      - string
    doc: Comma-separated names of the samples to use for adaptive polarization
    inputBinding:
      position: 101
      prefix: --polarize-guide-samples
  - id: polarize_n_prev
    type:
      - 'null'
      - int
    doc: Number of previous regions to use for adaptive polarization (0 to 
      disable)
    default: 3
    inputBinding:
      position: 101
      prefix: --polarize-n-prev
  - id: progress_bar
    type:
      - 'null'
      - boolean
    doc: Show the progress bar
    inputBinding:
      position: 101
      prefix: --progress-bar
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Reverse complement reverse strand sequences (for 'fasta' output)
    inputBinding:
      position: 101
      prefix: --reverse-complement
  - id: sequence_files
    type:
      - 'null'
      - type: array
        items: File
    doc: List of sequence file paths (FASTA or AGC) (required for 'gfa', 'maf', 
      and 'fasta')
    inputBinding:
      position: 101
      prefix: --sequence-files
  - id: sequence_list
    type:
      - 'null'
      - File
    doc: Path to a text file containing paths to sequence files (FASTA or AGC) 
      (required for 'gfa', 'maf', and 'fasta')
    inputBinding:
      position: 101
      prefix: --sequence-list
  - id: subset_sequence_list
    type:
      - 'null'
      - File
    doc: Path to a file listing sequence names to include (one per line)
    inputBinding:
      position: 101
      prefix: --subset-sequence-list
  - id: target_bed
    type:
      - 'null'
      - File
    doc: Path to the BED file containing target regions
    inputBinding:
      position: 101
      prefix: --target-bed
  - id: target_range
    type:
      - 'null'
      - string
    doc: Target range in the format `seq_name:start-end`
    inputBinding:
      position: 101
      prefix: --target-range
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: transitive
    type:
      - 'null'
      - boolean
    doc: Enable transitive queries (with Breadth-First Search)
    inputBinding:
      position: 101
      prefix: --transitive
  - id: transitive_dfs
    type:
      - 'null'
      - boolean
    doc: Enable transitive queries with Depth-First Search (slower, but returns 
      fewer overlapping results)
    inputBinding:
      position: 101
      prefix: --transitive-dfs
  - id: verbose
    type:
      - 'null'
      - int
    doc: Verbosity level (0 = error, 1 = info, 2 = debug)
    default: 0
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
stdout: impg_similarity.out
