cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgcg
label: zol_cgcg
doc: |-
  cgcg (collapsed gene clusters graph) builds a graph of orthogroups from zol results.

  Tool homepage: https://github.com/Kalan-Lab/zol
inputs:
  - id: zol_results_dir
    type: Directory
    doc: 'Path to zol results directory.'
    inputBinding:
      position: 1
      prefix: --zol-results-dir
  - id: outdir
    type: string
    doc: 'See the tool help.'
    inputBinding:
      position: 1
      prefix: --outdir
  - id: color_track
    type: ['null', string]
    doc: 'The track from the zol spreadsheet to use for coloring. Options include: conservation, tajimas_d, entorpy, upstream_entropy, median_beta_rd, max_beta_rd, fst, alternative_conservation, bgc_score, viral_score, busrted_pval. [Default is conservation].'
    inputBinding:
      position: 1
      prefix: --color-track
  - id: low_value
    type: ['null', float]
    doc: 'Low value [Default is 0.0].'
    inputBinding:
      position: 1
      prefix: --low-value
  - id: high_value
    type: ['null', float]
    doc: 'High value [Default is 1.0].'
    inputBinding:
      position: 1
      prefix: --high-value
  - id: low_value_color
    type: ['null', string]
    doc: 'Hex code for color for low-value. Surround by quotes [Default is ''#a2b7e8''].'
    inputBinding:
      position: 1
      prefix: --low-value-color
  - id: high_value_color
    type: ['null', string]
    doc: 'Hex code for color for high-value. Surround by quotes [Default is ''#102f75''].'
    inputBinding:
      position: 1
      prefix: --high-value-color
  - id: na_value_color
    type: ['null', string]
    doc: 'The hex code for setting color of NA/non-numeric values. Suround by quotes. [Default is ''#adadad''].'
    inputBinding:
      position: 1
      prefix: --na-value-color
  - id: min_conservation
    type: ['null', float]
    doc: 'Minimum conservation of ortholog group to be shown [Default is 0.25].'
    inputBinding:
      position: 1
      prefix: --min-conservation
  - id: min_edge_ratio
    type: ['null', float]
    doc: 'Minimum ratio of weight between two ortholog groups to the maximum weight observed to be shown [Default is 0.05].'
    inputBinding:
      position: 1
      prefix: --min-edge-ratio
  - id: custom_labels
    type: ['null', File]
    doc: 'Tab-separated file with OG identifiers as first column and labels to use as the second column.'
    inputBinding:
      position: 1
      prefix: --custom-labels
  - id: custom_colors
    type: ['null', File]
    doc: 'Tab-separated file with OG identifiers as first column and hex-code for colors to use as the second column.'
    inputBinding:
      position: 1
      prefix: --custom-colors
  - id: arrow_size
    type: ['null', float]
    doc: 'Arrow size [Default is 10].'
    inputBinding:
      position: 1
      prefix: --arrow-size
  - id: node_border_size
    type: ['null', float]
    doc: 'Node border size [Default is 1]. coloring for orthogroup consensus direction.'
    inputBinding:
      position: 1
      prefix: --node-border-size
  - id: undirected_graph
    type: ['null', boolean]
    doc: 'Flag for hiding arrows.'
    inputBinding:
      position: 1
      prefix: --undirected-graph
  - id: background_color
    type: ['null', string]
    doc: 'The background color. Surround by quotes [Default is "#FFFFFF"].'
    inputBinding:
      position: 1
      prefix: --background-color
  - id: show_major_path
    type: ['null', boolean]
    doc: 'Flag to show edges which belong to the major path in gold.'
    inputBinding:
      position: 1
      prefix: --show-major-path
outputs:
  - id: output_directory
    type: ['null', Directory]
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/zol:1.6.17--py312hf731ba3_1
