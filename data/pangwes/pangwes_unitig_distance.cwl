cwlVersion: v1.2
class: CommandLineTool
baseCommand: pangwes_unitig_distance
label: pangwes_unitig_distance
doc: "Calculate unitig distances in graphs and single genome graphs, with tools for
  determining outliers.\n\nTool homepage: https://github.com/jurikuronen/PANGWES"
inputs:
  - id: all_one_based
    type:
      - 'null'
      - boolean
    doc: Use one-based numbering for everything.
    inputBinding:
      position: 101
      prefix: --all-one-based
  - id: edges_file
    type:
      - 'null'
      - File
    doc: Path to file containing graph edges.
    inputBinding:
      position: 101
      prefix: --edges-file
  - id: graphs_one_based
    type:
      - 'null'
      - boolean
    doc: Graph files use one-based numbering.
    inputBinding:
      position: 101
      prefix: --graphs-one-based
  - id: k_mer_length
    type:
      - 'null'
      - int
    doc: k-mer length.
    inputBinding:
      position: 101
      prefix: --k-mer-length
  - id: ld_distance
    type:
      - 'null'
      - int
    doc: Linkage disequilibrium distance (automatically determined if negative).
    default: -1
    inputBinding:
      position: 101
      prefix: --ld-distance
  - id: ld_distance_min
    type:
      - 'null'
      - int
    doc: Minimum ld distance for automatic ld distance determination.
    default: 1000
    inputBinding:
      position: 101
      prefix: --ld-distance-min
  - id: ld_distance_nth_score
    type:
      - 'null'
      - int
    doc: Use nth max score for automatic ld distance determination.
    default: 10
    inputBinding:
      position: 101
      prefix: --ld-distance-nth-score
  - id: ld_distance_score
    type:
      - 'null'
      - float
    doc: Score difference threshold for automatic ld distance determination.
    default: 0.8
    inputBinding:
      position: 101
      prefix: --ld-distance-score
  - id: max_distance
    type:
      - 'null'
      - string
    doc: Maximum allowed graph distance (for constraining the searches).
    default: inf
    inputBinding:
      position: 101
      prefix: --max-distance
  - id: n_queries
    type:
      - 'null'
      - string
    doc: Number of queries to read from the queries file.
    default: inf
    inputBinding:
      position: 101
      prefix: --n-queries
  - id: outlier_threshold
    type:
      - 'null'
      - float
    doc: Set outlier threshold to a custom value.
    inputBinding:
      position: 101
      prefix: --outlier-threshold
  - id: output_one_based
    type:
      - 'null'
      - boolean
    doc: Output files use one-based numbering.
    inputBinding:
      position: 101
      prefix: --output-one-based
  - id: queries_file
    type:
      - 'null'
      - File
    doc: Path to queries file.
    inputBinding:
      position: 101
      prefix: --queries-file
  - id: queries_format
    type:
      - 'null'
      - int
    doc: Set queries format manually (0..5).
    default: -1
    inputBinding:
      position: 101
      prefix: --queries-format
  - id: queries_one_based
    type:
      - 'null'
      - boolean
    doc: Queries file uses one-based numbering.
    inputBinding:
      position: 101
      prefix: --queries-one-based
  - id: run_sggs_only
    type:
      - 'null'
      - boolean
    doc: Calculate distances only in the single genome graphs.
    inputBinding:
      position: 101
      prefix: --run-sggs-only
  - id: sgg_count_threshold
    type:
      - 'null'
      - int
    doc: Filter low count single genome graph distances.
    default: 10
    inputBinding:
      position: 101
      prefix: --sgg-count-threshold
  - id: sgg_paths_file
    type:
      - 'null'
      - File
    doc: Path to file containing paths to single genome graph edge files.
    inputBinding:
      position: 101
      prefix: --sgg-paths-file
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads.
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: unitigs_file
    type:
      - 'null'
      - File
    doc: Path to file containing unitigs.
    inputBinding:
      position: 101
      prefix: --unitigs-file
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Be verbose.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output_outliers
    type:
      - 'null'
      - File
    doc: Output a list of outliers and outlier statistics.
    outputBinding:
      glob: $(inputs.output_outliers)
  - id: output_stem
    type:
      - 'null'
      - File
    doc: Path for output files (without extension).
    outputBinding:
      glob: $(inputs.output_stem)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pangwes:0.3.0_alpha--h9948957_1
