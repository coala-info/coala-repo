cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deva
  - visualize
label: blacksheep-outliers_visualize
doc: "Used to make custom heatmaps from significant genes.\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs:
  - id: comparison_qvalues
    type: File
    doc: Table of qvalues, output from compare_groups. Must be .csv or .tsv. Has genes/sites as rows and comparison values as columns.
    inputBinding:
      position: 1
  - id: annotations
    type: File
    doc: Table of annotations used to generate qvalues.
    inputBinding:
      position: 2
  - id: visualization_table
    type: File
    doc: Values to visualize in heatmap. Samples as columns and genes/sites as rows. Using outlier fraction table is recommended, but original values can also be used if no aggregation was used.
    inputBinding:
      position: 3
  - id: comparison_of_interest
    type: string
    doc: Name of column in qvalues table from which to visualize significant genes.
    inputBinding:
      position: 4
  - id: annotation_colors
    type:
      - 'null'
      - File
    doc: File with color map to use for annotation header. Must have a line with 'value color' format for each value in annotations. Any value not represented will be assigned a new color.
    inputBinding:
      position: 102
      prefix: --annotation_colors
  - id: annotations_to_show
    type:
      - 'null'
      - type: array
        items: string
    doc: Names of columns from the annotation table to show in the header of the heatmap. Default is all columns.
    inputBinding:
      position: 102
      prefix: --annotations_to_show
  - id: fdr
    type:
      - 'null'
      - float
    doc: FDR threshold to use to select genes to visualize. Default 0.05
    inputBinding:
      position: 102
      prefix: --fdr
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
  - id: write_gene_list
    type:
      - 'null'
      - boolean
    doc: Use flag to write a list of significantly enriched genes for each value in each comparison.
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
