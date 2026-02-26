cwlVersion: v1.2
class: CommandLineTool
baseCommand: csv2heatmap.py
label: amptk_heatmap
doc: "Script that creates heatmap(s) from csv data, column 1 is the row name, csv
  file has headers.\n\nTool homepage: https://github.com/nextgenusfs/amptk"
inputs:
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: Annotate heatmap with values
    default: false
    inputBinding:
      position: 101
      prefix: --annotate
  - id: cluster_columns
    type:
      - 'null'
      - boolean
    doc: Cluster columns
    default: false
    inputBinding:
      position: 101
      prefix: --cluster_columns
  - id: cluster_method
    type:
      - 'null'
      - string
    doc: Clustering method for clustermap
    default: single
    inputBinding:
      position: 101
      prefix: --cluster_method
  - id: color
    type:
      - 'null'
      - string
    doc: Color palette
    default: gist_gray_r
    inputBinding:
      position: 101
      prefix: --color
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Print the data table to terminal
    default: false
    inputBinding:
      position: 101
      prefix: --debug
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Input file (csv)
    default: tsv
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: distance_metric
    type:
      - 'null'
      - string
    doc: Distance metric for clustermap
    default: braycurtis
    inputBinding:
      position: 101
      prefix: --distance_metric
  - id: figsize
    type:
      - 'null'
      - string
    doc: Figure size (3x5, 2x10, etc)
    default: 2x8
    inputBinding:
      position: 101
      prefix: --figsize
  - id: font
    type:
      - 'null'
      - string
    doc: Font set
    default: arial
    inputBinding:
      position: 101
      prefix: --font
  - id: format
    type:
      - 'null'
      - string
    doc: format to save image in
    default: pdf
    inputBinding:
      position: 101
      prefix: --format
  - id: input_file
    type: File
    doc: Input file (csv)
    inputBinding:
      position: 101
      prefix: --input
  - id: method
    type:
      - 'null'
      - string
    doc: Type of heatmap
    default: clustermap
    inputBinding:
      position: 101
      prefix: --method
  - id: normalize
    type:
      - 'null'
      - string
    doc: Normalize data to pct of total, tsv sample ID<tab>reads
    default: None
    inputBinding:
      position: 101
      prefix: --normalize
  - id: normalize_counts
    type:
      - 'null'
      - int
    doc: Value to normalize read counts to
    default: 100000
    inputBinding:
      position: 101
      prefix: --normalize_counts
  - id: scaling
    type:
      - 'null'
      - string
    doc: Scale the data by row
    default: None
    inputBinding:
      position: 101
      prefix: --scaling
  - id: vmax
    type:
      - 'null'
      - string
    doc: Max value for heatmap
    default: None
    inputBinding:
      position: 101
      prefix: --vmax
  - id: xaxis_fontsize
    type:
      - 'null'
      - int
    doc: Font size for x-axis
    default: 6
    inputBinding:
      position: 101
      prefix: --xaxis_fontsize
  - id: yaxis_fontsize
    type:
      - 'null'
      - int
    doc: Font size for y-axis
    default: 6
    inputBinding:
      position: 101
      prefix: --yaxis_fontsize
outputs:
  - id: output_file
    type: File
    doc: Output file (pdf)
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amptk:1.6.0--pyhdfd78af_0
