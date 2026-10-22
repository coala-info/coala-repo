cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - skani
  - triangle
label: skani_triangle
doc: "Compute a lower triangular ANI/AF matrix. Usage: skani triangle genome1.fa genome2.fa genome3.fa ...\n\nTool homepage: https://github.com/bluenote-1577/skani"
inputs:
  - id: fasta_files
    type:
      - 'null'
      - type: array
        items: File
    doc: 'Fasta(s) or sketch(es)'
    inputBinding:
      position: 1
  - id: fasta_list
    type:
      - 'null'
      - File
    doc: 'File with each line containing one fasta/sketch file'
    inputBinding:
      position: 101
      prefix: -l
  - id: individual_sequences
    type:
      - 'null'
      - boolean
    doc: 'Use individual sequences instead the entire file for multi-fastas'
    inputBinding:
      position: 101
      prefix: -i
  - id: both_min_af
    type:
      - 'null'
      - float
    doc: 'Only output ANI values where both genomes have aligned fraction > than this value. Default disabled'
    inputBinding:
      position: 101
      prefix: --both-min-af
  - id: ci
    type:
      - 'null'
      - boolean
    doc: 'Output [5%,95%] ANI confidence intervals using percentile bootstrap on the putative ANI distribution. Only works with --sparse or -E'
    inputBinding:
      position: 101
      prefix: --ci
  - id: detailed
    type:
      - 'null'
      - boolean
    doc: 'Print additional info including contig N50s and more'
    inputBinding:
      position: 101
      prefix: --detailed
  - id: diagonal
    type:
      - 'null'
      - boolean
    doc: 'Output the diagonal of the ANI matrix (self-self comparisons) for both dense and sparse matrices'
    inputBinding:
      position: 101
      prefix: --diagonal
  - id: distance
    type:
      - 'null'
      - boolean
    doc: 'Output 100 - ANI instead of ANI, creating a distance matrix. No effect if using --sparse or -E'
    inputBinding:
      position: 101
      prefix: --distance
  - id: sparse
    type:
      - 'null'
      - boolean
    doc: 'Output comparisons in a row-by-row form (sparse matrix) in the same form as skani dist'
    inputBinding:
      position: 101
      prefix: -E
  - id: full_matrix
    type:
      - 'null'
      - boolean
    doc: 'Output full matrix instead of lower-triangular matrix'
    inputBinding:
      position: 101
      prefix: --full-matrix
  - id: min_af
    type:
      - 'null'
      - float
    doc: 'Only output ANI values where one genome has aligned fraction > than this value. Default 15'
    inputBinding:
      position: 101
      prefix: --min-af
  - id: short_header
    type:
      - 'null'
      - boolean
    doc: 'Only display the first part of contig names (before first whitespace)'
    inputBinding:
      position: 101
      prefix: --short-header
  - id: fast
    type:
      - 'null'
      - boolean
    doc: 'Faster skani mode; 2x faster and less memory. Alias for -c 200'
    inputBinding:
      position: 101
      prefix: --fast
  - id: medium
    type:
      - 'null'
      - boolean
    doc: 'Medium skani mode; 2x slower, more accurate AF and ANI for moderately fragmented assemblies. Alias for -c 70'
    inputBinding:
      position: 101
      prefix: --medium
  - id: slow
    type:
      - 'null'
      - boolean
    doc: 'Slower skani mode; 4x slower, much more accurate AF for distant genomes. Alias for -c 30'
    inputBinding:
      position: 101
      prefix: --slow
  - id: small_genomes
    type:
      - 'null'
      - boolean
    doc: 'Mode for small genomes such as viruses or plasmids (< 20 kb). Alias for -c 30 -m 200 --faster-small'
    inputBinding:
      position: 101
      prefix: --small-genomes
  - id: compression_factor
    type:
      - 'null'
      - int
    doc: 'Compression factor (k-mer subsampling rate). Default 125'
    inputBinding:
      position: 101
      prefix: -c
  - id: marker_c
    type:
      - 'null'
      - int
    doc: 'Marker k-mer compression factor. Markers are used for filtering. Default 1000'
    inputBinding:
      position: 101
      prefix: -m
  - id: faster_small
    type:
      - 'null'
      - boolean
    doc: 'Filter genomes with < 20 marker k-mers more aggressively. Much faster for many small genomes but may miss some comparisons'
    inputBinding:
      position: 101
      prefix: --faster-small
  - id: median
    type:
      - 'null'
      - boolean
    doc: 'Estimate median identity instead of average (mean) identity'
    inputBinding:
      position: 101
      prefix: --median
  - id: no_learned_ani
    type:
      - 'null'
      - boolean
    doc: 'Disable regression model for ANI prediction'
    inputBinding:
      position: 101
      prefix: --no-learned-ani
  - id: robust
    type:
      - 'null'
      - boolean
    doc: 'Estimate mean after trimming off 10%/90% quantiles'
    inputBinding:
      position: 101
      prefix: --robust
  - id: screen_identity
    type:
      - 'null'
      - int
    doc: 'Screen out pairs with approximately < this percent identity using k-mer sketching. Default 80'
    inputBinding:
      position: 101
      prefix: -s
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of threads. Default 3'
    inputBinding:
      position: 101
      prefix: -t
  - id: trace
    type:
      - 'null'
      - boolean
    doc: 'Trace level verbosity'
    inputBinding:
      position: 101
      prefix: --trace
  - id: debug
    type:
      - 'null'
      - boolean
    doc: 'Debug level verbosity'
    inputBinding:
      position: 101
      prefix: -v
  - id: output_file_path
    type: string
    doc: 'Output file name'
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: Output ANI matrix or table
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/skani:0.3.1--ha6fb395_0
