cwlVersion: v1.2
class: CommandLineTool
baseCommand: ssu
label: unifrac_ssu
doc: "Compute UniFrac distances between samples based on phylogenetic relationships.\n\
  \nTool homepage: https://github.com/biocore/unifrac"
inputs:
  - id: alpha
    type:
      - 'null'
      - float
    doc: Generalized UniFrac alpha, default is 1.
    inputBinding:
      position: 101
      prefix: -a
  - id: bypass_tips
    type:
      - 'null'
      - boolean
    doc: Bypass tips, reduces compute by about 50%.
    inputBinding:
      position: 101
      prefix: -f
  - id: deprecated_no_op
    type:
      - 'null'
      - boolean
    doc: DEPRECATED, no-op.
    inputBinding:
      position: 101
      prefix: -n
  - id: disk_buffer_path
    type:
      - 'null'
      - Directory
    doc: Use a disk buffer to reduce memory footprint. Provide path to a fast 
      partition (ideally NVMe).
    inputBinding:
      position: 101
      prefix: --diskbuf
  - id: grouping_columns
    type:
      - 'null'
      - type: array
        items: string
    doc: The columns(s) to use for grouping, multiple values comma separated.
    inputBinding:
      position: 101
      prefix: -c
  - id: grouping_file
    type:
      - 'null'
      - File
    doc: The input grouping in TSV.
    inputBinding:
      position: 101
      prefix: -g
  - id: input_biom_table
    type: File
    doc: The input BIOM table.
    inputBinding:
      position: 101
      prefix: -i
  - id: method
    type: string
    doc: The method, [unweighted | weighted_normalized | weighted_unnormalized |
      unweighted_unnormalized | generalized | unweighted_fp64 | 
      weighted_normalized_fp64 | weighted_unnormalized_fp64 | 
      unweighted_unnormalized_fp64 | generalized_fp64 | unweighted_fp32 | 
      weighted_normalized_fp32 | weighted_unnormalized_fp32 | 
      unweighted_unnormalized_fp32 | generalized_fp32].
    inputBinding:
      position: 101
      prefix: -m
  - id: mode
    type:
      - 'null'
      - string
    doc: 'Mode of operation: one-off : [DEFAULT] compute UniFrac. partial : Compute
      UniFrac over a subset of stripes. partial-report : Start and stop suggestions
      for partial compute. merge-partial : Merge partial UniFrac results. check-partial
      : Check partial UniFrac results. multi : compute UniFrac multiple times.'
    inputBinding:
      position: 101
      prefix: --mode
  - id: n_partitions
    type:
      - 'null'
      - int
    doc: If mode==partial-report, the number of partitions to compute.
    inputBinding:
      position: 101
      prefix: --n-partials
  - id: n_subsamples
    type:
      - 'null'
      - int
    doc: 'if mode==multi, number of subsampled UniFracs to compute (default: 100)'
    inputBinding:
      position: 101
      prefix: --n-subsamples
  - id: n_substeps
    type:
      - 'null'
      - int
    doc: Internally split the problem in n substeps for reduced memory 
      footprint, default is 1.
    inputBinding:
      position: 101
      prefix: --n-substeps
  - id: newick_tree
    type: File
    doc: The input phylogeny in newick.
    inputBinding:
      position: 101
      prefix: -t
  - id: output_format
    type:
      - 'null'
      - string
    doc: 'Output format: ascii : Original ASCII format. (default if mode==one-off)
      hdf5 : HFD5 format. May be fp32 or fp64, depending on method. hdf5_fp32 : HFD5
      format, using fp32 precision. hdf5_fp64 : HFD5 format, using fp64 precision.
      hdf5_nodist : HFD5 format, no distance matrix. (default if mode==multi)'
    inputBinding:
      position: 101
      prefix: --format
  - id: partial_pattern
    type:
      - 'null'
      - string
    doc: If mode==merge-partial or check-partial, a glob pattern for partial 
      outputs to merge.
    inputBinding:
      position: 101
      prefix: --partial-pattern
  - id: pcoa_dimensions
    type:
      - 'null'
      - int
    doc: 'Number of PCoA dimensions to compute (default: 10, do not compute if 0)'
    inputBinding:
      position: 101
      prefix: --pcoa
  - id: permanova_permutations
    type:
      - 'null'
      - int
    doc: 'Number of PERMANOVA permutations to compute (default: 999 with -g, do not
      compute if 0)'
    inputBinding:
      position: 101
      prefix: --permanova
  - id: report_bare
    type:
      - 'null'
      - boolean
    doc: If mode==partial-report, produce barebones output.
    inputBinding:
      position: 101
      prefix: --report-bare
  - id: seed
    type:
      - 'null'
      - int
    doc: Seed to use for initializing the random gnerator
    inputBinding:
      position: 101
      prefix: --seed
  - id: start_stripe
    type:
      - 'null'
      - int
    doc: If mode==partial, the starting stripe.
    inputBinding:
      position: 101
      prefix: --start
  - id: stop_stripe
    type:
      - 'null'
      - int
    doc: If mode==partial, the stopping stripe.
    inputBinding:
      position: 101
      prefix: --stop
  - id: subsample_depth
    type:
      - 'null'
      - int
    doc: Depth of subsampling of the input BIOM before computing unifrac 
      (required for mode==multi, optional for one-off)
    inputBinding:
      position: 101
  - id: subsample_replacement
    type:
      - 'null'
      - boolean
    doc: Subsample with or without replacement (default is with)
    inputBinding:
      position: 101
      prefix: --subsample-replacement
  - id: variance_adjusted
    type:
      - 'null'
      - boolean
    doc: Variance adjusted, default is to not adjust for variance.
    inputBinding:
      position: 101
      prefix: --vaw
outputs:
  - id: output_distance_matrix
    type: File
    doc: The output distance matrix.
    outputBinding:
      glob: $(inputs.output_distance_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unifrac:1.5.1--py39hff726c5_0
