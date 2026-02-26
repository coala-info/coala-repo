cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skani
  - search
label: skani_search
doc: "Search queries against a large pre-sketched database of reference genomes in
  a memory efficient manner.\n\nTool homepage: https://github.com/bluenote-1577/skani"
inputs:
  - id: queries
    type:
      - 'null'
      - type: array
        items: File
    doc: Query fasta(s) or sketch(es)
    inputBinding:
      position: 1
  - id: both_min_af
    type:
      - 'null'
      - float
    doc: Only output ANI values where both genomes have aligned fraction > than 
      this value.
    default: disabled
    inputBinding:
      position: 102
      prefix: --both-min-af
  - id: database
    type: Directory
    doc: Output folder from `skani sketch`
    inputBinding:
      position: 102
      prefix: -d
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Debug level verbosity
    inputBinding:
      position: 102
      prefix: --debug
  - id: detailed_output
    type:
      - 'null'
      - boolean
    doc: Print additional info including contig N50s and more
    inputBinding:
      position: 102
      prefix: --detailed
  - id: keep_refs
    type:
      - 'null'
      - boolean
    doc: Keep reference sketches in memory if the sketch passes the marker 
      filter. Takes more memory but is much faster when querying many similar 
      sequences
    inputBinding:
      position: 102
      prefix: --keep-refs
  - id: max_results
    type:
      - 'null'
      - int
    doc: Max number of results to show for each query.
    default: unlimited
    inputBinding:
      position: 102
      prefix: -n
  - id: median_identity
    type:
      - 'null'
      - boolean
    doc: Estimate median identity instead of average (mean) identity
    inputBinding:
      position: 102
      prefix: --median
  - id: min_af
    type:
      - 'null'
      - float
    doc: Only output ANI values where one genome has aligned fraction > than 
      this value.
    default: 15
    inputBinding:
      position: 102
      prefix: --min-af
  - id: no_learned_ani
    type:
      - 'null'
      - boolean
    doc: 'Disable regression model for ANI prediction. [default: learned ANI used
      for c >= 70 and >= 150,000 bases aligned and not on individual contigs]'
    inputBinding:
      position: 102
      prefix: --no-learned-ani
  - id: no_marker_index
    type:
      - 'null'
      - boolean
    doc: 'Do not use hash-table inverted index for faster ANI filtering. [default:
      load index if > 100 query files or using the --qi option]'
    inputBinding:
      position: 102
      prefix: --no-marker-index
  - id: output_confidence_intervals
    type:
      - 'null'
      - boolean
    doc: Output [5%,95%] ANI confidence intervals using percentile bootstrap on 
      the putative ANI distribution
    inputBinding:
      position: 102
      prefix: --ci
  - id: query_individual_sequences
    type:
      - 'null'
      - boolean
    doc: Use individual sequences for the QUERY in a multi-line fasta
    inputBinding:
      position: 102
      prefix: --qi
  - id: query_list
    type:
      - 'null'
      - type: array
        items: File
    doc: File with each line containing one fasta/sketch file
    inputBinding:
      position: 102
      prefix: --ql
  - id: robust_estimation
    type:
      - 'null'
      - boolean
    doc: Estimate mean after trimming off 10%/90% quantiles
    inputBinding:
      position: 102
      prefix: --robust
  - id: screen_identity
    type:
      - 'null'
      - int
    doc: Screen out pairs with *approximately* < % identity using k-mer 
      sketching.
    default: 80
    inputBinding:
      position: 102
      prefix: -s
  - id: short_header
    type:
      - 'null'
      - boolean
    doc: Only display the first part of contig names (before first whitespace)
    inputBinding:
      position: 102
      prefix: --short-header
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: 3
    inputBinding:
      position: 102
      prefix: -t
  - id: trace_verbosity
    type:
      - 'null'
      - boolean
    doc: Trace level verbosity
    inputBinding:
      position: 102
      prefix: --trace
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
