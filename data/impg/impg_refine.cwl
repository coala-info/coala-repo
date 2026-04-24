cwlVersion: v1.2
class: CommandLineTool
baseCommand: impg_refine
label: impg_refine
doc: "Refine loci to maximize the number of samples that span both ends of the region\n\
  \nTool homepage: https://github.com/pangenome/impg"
inputs:
  - id: extension_step
    type:
      - 'null'
      - int
    doc: Step size for expanding flanks (bp)
    inputBinding:
      position: 101
      prefix: --extension-step
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
    inputBinding:
      position: 101
      prefix: --max-depth
  - id: max_extension
    type:
      - 'null'
      - float
    doc: Maximum per-side extension explored when maximizing boundary support. 
      Values <= 1 are treated as fractions of the locus length; values > 1 as 
      absolute bp
    inputBinding:
      position: 101
      prefix: --max-extension
  - id: merge_distance
    type:
      - 'null'
      - int
    doc: Maximum distance between regions to merge
    inputBinding:
      position: 101
      prefix: --merge-distance
  - id: min_distance_between_ranges
    type:
      - 'null'
      - int
    doc: Minimum distance between transitive ranges to consider on the same 
      sequence
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
  - id: pansn_mode
    type:
      - 'null'
      - string
    doc: 'PanSN aggregation mode when counting support (sample/haplotype) [possible
      values: sample, haplotype]'
    inputBinding:
      position: 101
      prefix: --pansn-mode
  - id: span_bp
    type:
      - 'null'
      - int
    doc: Minimum number of bases that supporting samples must span at each 
      region boundary
    inputBinding:
      position: 101
      prefix: --span-bp
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
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: support_output
    type:
      - 'null'
      - File
    doc: Optional BED file capturing the entities that span the refined region
    outputBinding:
      glob: $(inputs.support_output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/impg:0.3.3--hdb3fbb7_0
