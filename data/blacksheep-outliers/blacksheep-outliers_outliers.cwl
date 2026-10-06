cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deva
  - outliers
label: blacksheep-outliers_outliers
doc: "Runs whole outliers pipeline. Has options to output every possible output.\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs:
  - id: values
    type: File
    doc: File path to input values. Samples are columns and genes/sites are rows. Only .tsv and .csv accepted.
    inputBinding:
      position: 1
  - id: annotations
    type: File
    doc: File path to annotation values. Rows are sample names, header is different annotations. e.g. mutation status.
    inputBinding:
      position: 2
  - id: annotation_colors
    type:
      - 'null'
      - File
    doc: File with color map to use for annotation header. Must have a line with 'value color' format for each value in annotations. Any value not represented will be assigned a new color.
    inputBinding:
      position: 102
      prefix: --annotation_colors
  - id: do_not_aggregate
    type:
      - 'null'
      - boolean
    doc: Use flag if you do not want to sum outliers based on site prefixes.
    inputBinding:
      position: 102
      prefix: --do_not_aggregate
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR threshold to use to select genes to visualize. Default 0.05
    inputBinding:
      position: 102
      prefix: --fdr
  - id: frac_filter
    type:
      - 'null'
      - float
    doc: The minimum fraction of samples per group that must have an outlier in a gene to consider that gene in the analysis. Default 0.3
    inputBinding:
      position: 102
      prefix: --frac_filter
  - id: ind_sep
    type:
      - 'null'
      - string
    doc: If site labels have a parent molecule (e.g. a gene name such as ATM) and a site identifier (e.g. S365) this is the delimiter between the two elements. Default is -
    inputBinding:
      position: 102
      prefix: --ind_sep
  - id: iqrs
    type:
      - 'null'
      - float
    doc: Number of inter-quartile ranges (IQRs) above or below the median to consider a value an outlier. Default is 1.5.
    inputBinding:
      position: 102
      prefix: --iqrs
  - id: make_heatmaps
    type:
      - 'null'
      - boolean
    doc: Use flag to draw a heatmap of significantly enriched genes for each value in each comparison. If used, need an fdr threshold as well.
    inputBinding:
      position: 102
      prefix: --make_heatmaps
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix for writing files. Default outliers.
    inputBinding:
      position: 102
      prefix: --output_prefix
  - id: red_or_blue
    type:
      - 'null'
      - string
    doc: Color of values to draw on heatmap. Default red.
    inputBinding:
      position: 102
      prefix: --red_or_blue
  - id: up_or_down
    type:
      - 'null'
      - string
    doc: Whether to look for up or down outliers. Choices are up or down. Default up.
    inputBinding:
      position: 102
      prefix: --up_or_down
  - id: write_comparison_summaries
    type:
      - 'null'
      - boolean
    doc: Use flag to write a separate file for each column in the annotations table, with outlier counts in each group, p-values and q-values in each group.
    inputBinding:
      position: 102
      prefix: --write_comparison_summaries
  - id: write_frac_table
    type:
      - 'null'
      - boolean
    doc: Use flag if you want to write a table with fraction of values per site per sample that are outliers. Useful for custom visualization.
    inputBinding:
      position: 102
      prefix: --write_frac_table
  - id: write_gene_list
    type:
      - 'null'
      - boolean
    doc: Use flag to write a list of significantly enriched genes for each value in each comparison.
    inputBinding:
      position: 102
      prefix: --write_gene_list
  - id: write_outlier_table
    type:
      - 'null'
      - boolean
    doc: Use flag to write a table of outlier counts.
    inputBinding:
      position: 102
      prefix: --write_outlier_table
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Files written with the output prefix (tables, log, parameters, heatmaps,
      gene lists).
    outputBinding:
      glob: $((inputs.output_prefix || 'outliers') + '*')
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blacksheep-outliers:0.0.8--py_0
