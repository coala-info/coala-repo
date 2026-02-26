cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - impg
  - partition
label: impg_partition
doc: "Partition the alignment\n\nTool homepage: https://github.com/pangenome/impg"
inputs:
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
    default: 2
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between regions to merge
    default: 100000
    inputBinding:
      position: 101
      prefix: --merge-distance
  - id: min_boundary_distance
    type:
      - 'null'
      - int
    doc: Minimum distance from sequence start/end - closer regions will be 
      extended to the boundaries
    default: 3000
    inputBinding:
      position: 101
      prefix: --min-boundary-distance
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
  - id: min_missing_size
    type:
      - 'null'
      - int
    doc: Minimum region size for missing regions
    default: 3000
    inputBinding:
      position: 101
      prefix: --min-missing-size
  - id: min_transitive_len
    type:
      - 'null'
      - int
    doc: Minimum region size to consider for transitive queries
    default: 10
    inputBinding:
      position: 101
      prefix: --min-transitive-len
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: Output folder for partition files
    default: current directory
    inputBinding:
      position: 101
      prefix: --output-folder
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output format: 'bed', 'gfa' (v1.0), 'maf', or 'fasta' ('gfa', 'maf', and
      'fasta' require --sequence-files or --sequence-list)"
    default: bed
    inputBinding:
      position: 101
      prefix: --output-format
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
  - id: reverse_complement
    type:
      - 'null'
      - boolean
    doc: Reverse complement reverse strand sequences (for 'fasta' output)
    inputBinding:
      position: 101
      prefix: --reverse-complement
  - id: selection_mode
    type:
      - 'null'
      - string
    doc: "Selection mode for next sequence: - \"longest\": sequence with longest single
      missing region - \"total\": sequence with highest total missing regions - \"\
      sample[,separator]\": sample with highest total missing regions - \"haplotype[,separator]\"\
      : haplotype highest total missing regions The sample/haplotype modes assume
      PanSN naming; '#' is the default separator."
    default: longest
    inputBinding:
      position: 101
      prefix: --selection-mode
  - id: separate_files
    type:
      - 'null'
      - boolean
    doc: Output separate files for each partition when 'bed'
    inputBinding:
      position: 101
      prefix: --separate-files
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
  - id: starting_sequences_file
    type:
      - 'null'
      - File
    doc: Path to the file with sequence names to start with (one per line)
    inputBinding:
      position: 101
      prefix: --starting-sequences-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads for parallel processing
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
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
  - id: window_size
    type: int
    doc: Window size for partitioning
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
stdout: impg_partition.out
