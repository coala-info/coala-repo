cwlVersion: v1.2
class: CommandLineTool
baseCommand: grimer
label: grimer
doc: "Grimer is a tool for visualizing and analyzing microbial community composition
  data.\n\nTool homepage: https://github.com/pirovc/grimer"
inputs:
  - id: config
    type:
      - 'null'
      - File
    doc: Configuration file with definitions of references, controls and 
      external tools.
    inputBinding:
      position: 101
      prefix: --config
  - id: cumm_levels
    type:
      - 'null'
      - boolean
    doc: Activate if input table has already cummulative values on parent 
      taxonomic levels.
    default: false
    inputBinding:
      position: 101
      prefix: --cumm-levels
  - id: decontam
    type:
      - 'null'
      - boolean
    doc: Run DECONTAM and generate plots. requires --config file with DECONTAM 
      configuration.
    default: false
    inputBinding:
      position: 101
      prefix: --decontam
  - id: full_offline
    type:
      - 'null'
      - boolean
    doc: Embed Bokeh javascript library in the output file. Output will be 
      around 1.5MB bigger but it will work without internet connection. ~your 
      report will live forever~
    default: false
    inputBinding:
      position: 101
      prefix: --full-offline
  - id: input_file
    type: File
    doc: Tab-separatad file with table with counts (Observation table, Count 
      table, Contingency Tables, ...) or .biom file. By default rows contain 
      observations and columns contain samples (use --transpose if your file is 
      reversed). The first column and first row are used as headers.
    inputBinding:
      position: 101
      prefix: --input-file
  - id: level_separator
    type:
      - 'null'
      - string
    doc: If provided, consider --input-table to be a hierarchical multi-level 
      table where the observations headers are separated by the indicated 
      separator char (usually ';' or '|')
    inputBinding:
      position: 101
      prefix: --level-separator
  - id: linkage_methods
    type:
      - 'null'
      - type: array
        items: string
    doc: Linkage methods for clustering.
    inputBinding:
      position: 101
      prefix: --linkage-methods
  - id: linkage_metrics
    type:
      - 'null'
      - type: array
        items: string
    doc: Linkage metrics for clustering.
    inputBinding:
      position: 101
      prefix: --linkage-metrics
  - id: max_count
    type:
      - 'null'
      - string
    doc: Define maximum number/percentage of counts to keep an observation 
      [values between 0-1 for percentage, >1 specific number].
    inputBinding:
      position: 101
      prefix: --max-count
  - id: max_frequency
    type:
      - 'null'
      - string
    doc: Define maximum number/percentage of samples containing an observation 
      to keep the observation [values between 0-1 for percentage, >1 specific 
      number].
    inputBinding:
      position: 101
      prefix: --max-frequency
  - id: metadata_cols
    type:
      - 'null'
      - int
    doc: Available metadata cols to be selected on the Heatmap panel. Higher 
      values will slow down the report navigation.
    default: 3
    inputBinding:
      position: 101
      prefix: --metadata-cols
  - id: metadata_file
    type:
      - 'null'
      - File
    doc: Tab-separated file with metadata. Rows should contain samples and 
      columns the metadata fields. QIIME2 metadata format is accepted, with an 
      extra row to define categorical and numerical fields. If --input-file is a
      .biom file, metadata will be extracted from it if available.
    inputBinding:
      position: 101
      prefix: --metadata-file
  - id: mgnify
    type:
      - 'null'
      - boolean
    doc: Plot MGnify, requires --config file with parsed MGnify database.
    default: false
    inputBinding:
      position: 101
      prefix: --mgnify
  - id: min_count
    type:
      - 'null'
      - string
    doc: Define minimum number/percentage of counts to keep an observation 
      [values between 0-1 for percentage, >1 specific number].
    inputBinding:
      position: 101
      prefix: --min-count
  - id: min_frequency
    type:
      - 'null'
      - string
    doc: Define minimum number/percentage of samples containing an observation 
      to keep the observation [values between 0-1 for percentage, >1 specific 
      number].
    inputBinding:
      position: 101
      prefix: --min-frequency
  - id: obs_replace
    type:
      - 'null'
      - type: array
        items: string
    doc: "Replace values on observations labels/headers (supports regex). Example:
      '_' ' ' will replace underscore with spaces, '^.+__' '' will remove the matching
      regex. Several pairs of instructions are supported."
    default: []
    inputBinding:
      position: 101
      prefix: --obs-replace
  - id: optimal_ordering
    type:
      - 'null'
      - boolean
    doc: Activate optimal_ordering on scipy linkage method, takes longer for 
      large number of samples.
    default: false
    inputBinding:
      position: 101
      prefix: --optimal-ordering
  - id: output_plots
    type:
      - 'null'
      - type: array
        items: string
    doc: Plots to generate.
    default:
      - overview
      - samples
      - heatmap
      - correlation
    inputBinding:
      position: 101
      prefix: --output-plots
  - id: ranks
    type:
      - 'null'
      - type: array
        items: string
    doc: Taxonomic ranks to generate visualizations. Use 'default' to use 
      entries from the table directly.
    default:
      - default
    inputBinding:
      position: 101
      prefix: --ranks
  - id: replace_zeros
    type:
      - 'null'
      - string
    doc: "Treat zeros in the input table. INT (add 'smallest count' divided by INT
      to every value), FLOAT (add FLOAT to every value). Default: 1000"
    default: '1000'
    inputBinding:
      position: 101
      prefix: --replace-zeros
  - id: sample_replace
    type:
      - 'null'
      - type: array
        items: string
    doc: "Replace values on sample labels/headers (supports regex). Example: '_' '
      ' will replace underscore with spaces, '^.+__' '' will remove the matching regex.
      Several pairs of instructions are supported."
    default: []
    inputBinding:
      position: 101
      prefix: --sample-replace
  - id: show_zeros
    type:
      - 'null'
      - boolean
    doc: Do not skip zeros on heatmap plot. File will be bigger and iteraction 
      with heatmap slower. By default, zeros will be omitted.
    default: false
    inputBinding:
      position: 101
      prefix: --show-zeros
  - id: skip_dendrogram
    type:
      - 'null'
      - boolean
    doc: Disable dendogram plots for clustering.
    default: false
    inputBinding:
      position: 101
      prefix: --skip-dendrogram
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Enable taxonomic analysis, convert entries and annotate samples. Files 
      will be automatically downloaded and parsed. Optionally, stored files can 
      be provided with --taxonomy-files.
    default: None
    inputBinding:
      position: 101
      prefix: --taxonomy
  - id: taxonomy_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Specific taxonomy files to use with --taxonomy.
    default: []
    inputBinding:
      position: 101
      prefix: --taxonomy-files
  - id: title
    type:
      - 'null'
      - string
    doc: Title to display on the top of the report.
    default: ''
    inputBinding:
      position: 101
      prefix: --title
  - id: top_obs_bars
    type:
      - 'null'
      - int
    doc: Number of top abundant observations to show in the Samples panel, based
      on the avg. percentage counts/sample.
    default: 20
    inputBinding:
      position: 101
      prefix: --top-obs-bars
  - id: top_obs_corr
    type:
      - 'null'
      - int
    doc: Number of top abundant observations to build the correlationn matrix, 
      based on the avg. percentage counts/sample. 0 for all
    default: 50
    inputBinding:
      position: 101
      prefix: --top-obs-corr
  - id: transformation
    type:
      - 'null'
      - string
    doc: Transformation of counts for Heatmap. none (counts), norm (percentage),
      log (log10), clr (centre log ratio).
    default: log
    inputBinding:
      position: 101
      prefix: --transformation
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Transpose --input-table before parsing (if samples are listed on 
      columns and observations on rows)
    default: false
    inputBinding:
      position: 101
      prefix: --transpose
  - id: unassigned_header
    type:
      - 'null'
      - type: array
        items: string
    doc: Define one or more header names containing unsassinged/unclassified 
      counts.
    inputBinding:
      position: 101
      prefix: --unassigned-header
  - id: values
    type:
      - 'null'
      - string
    doc: Force 'count' or 'normalized' data parsing. Empty to auto-detect.
    inputBinding:
      position: 101
      prefix: --values
outputs:
  - id: output_html
    type:
      - 'null'
      - File
    doc: Filename of the HTML report output.
    outputBinding:
      glob: $(inputs.output_html)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grimer:1.1.0--pyhdfd78af_0
