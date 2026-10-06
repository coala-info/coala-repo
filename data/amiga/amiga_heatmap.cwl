cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - amiga
  - heatmap
label: amiga_heatmap
doc: "Plot a heatmap\n\nTool homepage: https://github.com/firasmidani/amiga"
inputs:
  - id: input
    type: File
    doc: "Summary file of growth parameters"
    inputBinding:
      position: 1
      prefix: --input
  - id: output
    type: string
    doc: "Base name of the heatmap file (written next to the input as <output>.pdf)"
    inputBinding:
      position: 1
      prefix: --output
  - id: subset
    type: ['null', string]
    doc: "Subset of samples to analyze (e.g. 'Substrate:Glucose;Ribotype:RT027')"
    inputBinding:
      position: 1
      prefix: --subset
  - id: value
    type: string
    doc: "Growth parameter to plot (e.g. 'auc_log' or 'norm(gr)')"
    inputBinding:
      position: 1
      prefix: --value
  - id: x_variable
    type: string
    doc: "Meta-data variable for the x-axis"
    inputBinding:
      position: 1
      prefix: --x-variable
  - id: y_variable
    type: string
    doc: "Meta-data variable for the y-axis"
    inputBinding:
      position: 1
      prefix: --y-variable
  - id: operation
    type: ['null', {type: enum, symbols: [mean, median]}]
    doc: "How to summarize replicates (default mean)"
    inputBinding:
      position: 1
      prefix: --operation
  - id: filter
    type: ['null', string]
    doc: "Filter rows or columns (e.g. 'row any >= 1.2')"
    inputBinding:
      position: 1
      prefix: --filter
  - id: title
    type: ['null', string]
    doc: "Title of the heatmap"
    inputBinding:
      position: 1
      prefix: --title
  - id: kwargs
    type: ['null', string]
    doc: "Keyword arguments passed to seaborn clustermap (e.g. 'center:1;vmin:0')"
    inputBinding:
      position: 1
      prefix: --kwargs
  - id: verbose
    type: ['null', boolean]
    doc: "Print verbose messages"
    inputBinding:
      position: 1
      prefix: --verbose
  - id: save_filtered_table
    type: ['null', boolean]
    doc: "Save the filtered table used for the heatmap"
    inputBinding:
      position: 1
      prefix: --save-filtered-table
  - id: width_height
    type: ['null', {type: array, items: float}]
    doc: "Width and height of the figure"
    inputBinding:
      position: 1
      prefix: --width-height
  - id: colorbar_ratio
    type: ['null', float]
    doc: "Proportion of figure size devoted to color bar. Default is 0.1"
    inputBinding:
      position: 1
      prefix: --colorbar-ratio
  - id: color_x_by
    type: ['null', string]
    doc: "Meta-data variable used to color the columns"
    inputBinding:
      position: 1
      prefix: --color-x-by
  - id: color_y_by
    type: ['null', string]
    doc: "Meta-data variable used to color the rows"
    inputBinding:
      position: 1
      prefix: --color-y-by
  - id: color_file_x
    type: ['null', File]
    doc: "Tab-separated file of colors for the column labels"
    inputBinding:
      position: 1
      prefix: --color-file-x
  - id: color_file_y
    type: ['null', File]
    doc: "Tab-separated file of colors for the row labels"
    inputBinding:
      position: 1
      prefix: --color-file-y
  - id: color_scheme_x
    type: ['null', string]
    doc: "Colors for the column labels (e.g. 'RT027:red;RT053:blue')"
    inputBinding:
      position: 1
      prefix: --color-scheme-x
  - id: color_scheme_y
    type: ['null', string]
    doc: "Colors for the row labels"
    inputBinding:
      position: 1
      prefix: --color-scheme-y
  - id: color_x_ratio
    type: ['null', float]
    doc: "Proportion of the heatmap devoted to the column color labels. Default is 0.1"
    inputBinding:
      position: 1
      prefix: --color-x-ratio
  - id: color_y_ratio
    type: ['null', float]
    doc: "Proportion of the heatmap devoted to the row color labels. Default is 0.1"
    inputBinding:
      position: 1
      prefix: --color-y-ratio
  - id: missing_color
    type: ['null', string]
    doc: "Color for missing values"
    inputBinding:
      position: 1
      prefix: --missing-color
  - id: cluster_x
    type: ['null', boolean]
    doc: "Cluster the columns"
    inputBinding:
      position: 1
      prefix: --cluster-x
  - id: cluster_y
    type: ['null', boolean]
    doc: "Cluster the rows"
    inputBinding:
      position: 1
      prefix: --cluster-y
  - id: sort_x_by
    type: ['null', string]
    doc: "Variable used to sort the columns"
    inputBinding:
      position: 1
      prefix: --sort-x-by
  - id: sort_y_by
    type: ['null', string]
    doc: "Variable used to sort the rows"
    inputBinding:
      position: 1
      prefix: --sort-y-by
  - id: keep_rows_missing_data
    type: ['null', boolean]
    doc: "Keep rows that have missing data"
    inputBinding:
      position: 1
      prefix: --keep-rows-missing-data
  - id: keep_columns_missing_data
    type: ['null', boolean]
    doc: "Keep columns that have missing data"
    inputBinding:
      position: 1
      prefix: --keep-columns-missing-data
  - id: x_tick_labels_scale
    type: ['null', float]
    doc: "Must be between 0 (smallest) and 1 (largest)."
    inputBinding:
      position: 1
      prefix: --x-tick-labels-scale
  - id: y_tick_labels_scale
    type: ['null', float]
    doc: "Must be between 0 (smallest) and 1 (largest)."
    inputBinding:
      position: 1
      prefix: --y-tick-labels-scale
  - id: color_bar_labels_scale
    type: ['null', float]
    doc: "Must be between 0 (smallest) and 1 (largest)."
    inputBinding:
      position: 1
      prefix: --color-bar-labels-scale
  - id: x_rotation
    type: ['null', int]
    doc: "Rotation of the x-axis labels, in degrees (default 90)"
    inputBinding:
      position: 1
      prefix: --x-rotation
  - id: highlight_labels
    type: ['null', string]
    doc: "Labels to highlight (e.g. 'y:Glucose,Fructose')"
    inputBinding:
      position: 1
      prefix: --highlight-labels
outputs:
  - id: heatmap
    type: File
    doc: Heatmap (PDF)
    outputBinding:
      glob: $(inputs.output).pdf
  - id: extra_files
    type: File[]
    doc: Filtered table and color legends, when requested
    outputBinding:
      glob: $(inputs.output)_*
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amiga:3.0.4--pyhdfd78af_1
