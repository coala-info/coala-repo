cwlVersion: v1.2
class: CommandLineTool
baseCommand: skani dist
label: skani_dist
doc: "Compute ANI for queries against references fasta files or pre-computed sketch
  files.\n\nTool homepage: https://github.com/bluenote-1577/skani"
inputs:
  - id: query
    type:
      - 'null'
      - File
    doc: Query fasta or sketch
    inputBinding:
      position: 1
  - id: references
    type:
      - 'null'
      - type: array
        items: File
    doc: Reference fasta(s) or sketch(es)
    inputBinding:
      position: 2
  - id: both_min_aligned_fraction
    type:
      - 'null'
      - float
    doc: Only output ANI values where both genomes have aligned fraction > than 
      this value.
    default: disabled
    inputBinding:
      position: 103
      prefix: --both-min-af
  - id: compression_factor
    type:
      - 'null'
      - int
    doc: Compression factor (k-mer subsampling rate).
    default: 125
    inputBinding:
      position: 103
      prefix: -c
  - id: debug_verbosity
    type:
      - 'null'
      - boolean
    doc: Debug level verbosity
    inputBinding:
      position: 103
      prefix: --debug
  - id: detailed_output
    type:
      - 'null'
      - boolean
    doc: Print additional info including contig N50s and more
    inputBinding:
      position: 103
      prefix: --detailed
  - id: disable_learned_ani
    type:
      - 'null'
      - boolean
    doc: 'Disable regression model for ANI prediction. [default: learned ANI used
      for c >= 70 and >= 150,000 bases aligned and not on individual contigs]'
    inputBinding:
      position: 103
      prefix: --no-learned-ani
  - id: disable_marker_index
    type:
      - 'null'
      - boolean
    doc: 'Do not use hash-table inverted index for faster ANI filtering. [default:
      load index if > 100 query files or using the --qi option]'
    inputBinding:
      position: 103
      prefix: --no-marker-index
  - id: estimate_median_identity
    type:
      - 'null'
      - boolean
    doc: Estimate median identity instead of average (mean) identity
    inputBinding:
      position: 103
      prefix: --median
  - id: fast_mode
    type:
      - 'null'
      - boolean
    doc: Faster skani mode; 2x faster and less memory. Less accurate AF and less
      accurate ANI for distant genomes, but works ok for high N50 and > 95% ANI.
      Alias for -c 200
    inputBinding:
      position: 103
      prefix: --fast
  - id: faster_small_genomes
    type:
      - 'null'
      - boolean
    doc: Filter genomes with < 20 marker k-mers more aggressively. Much faster 
      for many small genomes but may miss some comparisons
    inputBinding:
      position: 103
      prefix: --faster-small
  - id: marker_kmer_compression_factor
    type:
      - 'null'
      - int
    doc: Marker k-mer compression factor. Markers are used for filtering. 
      Consider decreasing to ~200-300 if working with small genomes (e.g. 
      plasmids or viruses).
    default: 1000
    inputBinding:
      position: 103
      prefix: -m
  - id: max_results
    type:
      - 'null'
      - int
    doc: Max number of results to show for each query.
    default: unlimited
    inputBinding:
      position: 103
      prefix: -n
  - id: medium_mode
    type:
      - 'null'
      - boolean
    doc: Medium skani mode; 2x slower and more memory. More accurate AF and more
      accurate ANI for moderately fragmented assemblies (< 10kb N50). Alias for 
      -c 70
    inputBinding:
      position: 103
      prefix: --medium
  - id: min_aligned_fraction
    type:
      - 'null'
      - float
    doc: Only output ANI values where one genome has aligned fraction > than 
      this value.
    default: 15
    inputBinding:
      position: 103
      prefix: --min-af
  - id: output_confidence_intervals
    type:
      - 'null'
      - boolean
    doc: Output [5%,95%] ANI confidence intervals using percentile bootstrap on 
      the putative ANI distribution
    inputBinding:
      position: 103
      prefix: --ci
  - id: query_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Query fasta(s) or sketch(es)
    inputBinding:
      position: 103
      prefix: -q
  - id: query_list_file
    type:
      - 'null'
      - File
    doc: File with each line containing one fasta/sketch file
    inputBinding:
      position: 103
      prefix: --ql
  - id: reference_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Reference fasta(s) or sketch(es)
    inputBinding:
      position: 103
      prefix: -r
  - id: reference_list_file
    type:
      - 'null'
      - File
    doc: File with each line containing one fasta/sketch file
    inputBinding:
      position: 103
      prefix: --rl
  - id: robust_estimation
    type:
      - 'null'
      - boolean
    doc: Estimate mean after trimming off 10%/90% quantiles
    inputBinding:
      position: 103
      prefix: --robust
  - id: screen_identity_threshold
    type:
      - 'null'
      - int
    doc: Screen out pairs with *approximately* < % identity using k-mer 
      sketching.
    default: 80
    inputBinding:
      position: 103
      prefix: -s
  - id: short_header
    type:
      - 'null'
      - boolean
    doc: Only display the first part of contig names (before first whitespace)
    inputBinding:
      position: 103
      prefix: --short-header
  - id: slow_mode
    type:
      - 'null'
      - boolean
    doc: Slower skani mode; 4x slower and more memory. Gives much more accurate 
      AF for distant genomes. More accurate ANI for VERY fragmented assemblies 
      (< 3kb N50), but less accurate ANI otherwise. Alias for -c 30
    inputBinding:
      position: 103
      prefix: --slow
  - id: small_genomes_mode
    type:
      - 'null'
      - boolean
    doc: 'Mode for small genomes such as viruses or plasmids (< 20 kb). Can be much
      faster for large data, but is slower/less accurate on bacterial-sized genomes.
      Alias for: -c 30 -m 200 --faster-small'
    inputBinding:
      position: 103
      prefix: --small-genomes
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 3
    inputBinding:
      position: 103
      prefix: -t
  - id: trace_verbosity
    type:
      - 'null'
      - boolean
    doc: Trace level verbosity
    inputBinding:
      position: 103
      prefix: --trace
  - id: use_individual_query_sequences
    type:
      - 'null'
      - boolean
    doc: Use individual sequences for the QUERY in a multi-line fasta
    inputBinding:
      position: 103
      prefix: --qi
  - id: use_individual_reference_sequences
    type:
      - 'null'
      - boolean
    doc: Use individual sequences for the REFERENCE in a multi-line fasta
    inputBinding:
      position: 103
      prefix: --ri
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file name; rewrites file by default
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
