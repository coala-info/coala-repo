cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deva
  - compare_groups
label: blacksheep-outliers_compare_groups
doc: "Takes an annotation table and outlier count table (output of outliers_table) and outputs qvalues from a statistical test that looks for enrichment of outlier values in each group in the annotation table. For each value in each comparison, the qvalue table will have 1 column, if there are any genes in that comparison.\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs:
  - id: outliers_table
    type: File
    doc: Table of outlier counts (output of outliers_table). Must be .tsv or .csv file, with outlier and non-outlier counts as columns, and genes/sites as rows.
    inputBinding:
      position: 1
  - id: annotations
    type: File
    doc: Table of annotations. Must be .csv or .tsv. Samples as rows and comparisons as columns. Comparisons must have only unique values (not including missing values). If there are more options than that, you can use binarize to prepare the table.
    inputBinding:
      position: 2
  - id: annotation_colors
    type:
      - 'null'
      - File
    doc: File with color map to use for annotation header if --make_heatmaps is used. Must have a 'value color' format for each value in annotations. Any value not represented will be assigned a new color.
    inputBinding:
      position: 102
      prefix: --annotation_colors
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR cut off to use for significantly enriched gene lists and heatmaps. Default 0.05
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
  - id: iqrs
    type:
      - 'null'
      - float
    doc: Number of IQRs used to define outliers in the input count table. Optional.
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
    doc: If --make_heatmaps is called, color of values to draw on heatmap. Default red.
    inputBinding:
      position: 102
      prefix: --red_or_blue
  - id: up_or_down
    type:
      - 'null'
      - string
    doc: Whether input outlier table represents up or down outliers. Needed for output file labels. Default up
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
  - id: write_gene_list
    type:
      - 'null'
      - boolean
    doc: Use flag to write a list of significantly enriched genes for each value in each comparison. If used, need an fdr threshold as well.
    inputBinding:
      position: 102
      prefix: --write_gene_list
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
