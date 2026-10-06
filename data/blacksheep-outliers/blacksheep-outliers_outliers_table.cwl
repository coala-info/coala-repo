cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deva
  - outliers_table
label: blacksheep-outliers_outliers_table
doc: "Takes a table of values and converts to a table of outlier counts.\n\nTool homepage: https://github.com/ruggleslab/blackSheep/"
inputs:
  - id: values
    type: File
    doc: File path to input values. Columns must be samples, genes must be sites or genes. Only .tsv and .csv accepted.
    inputBinding:
      position: 1
  - id: do_not_aggregate
    type:
      - 'null'
      - boolean
    doc: Use flag if you do not want to sum outliers based on site prefixes.
    inputBinding:
      position: 102
      prefix: --do_not_aggregate
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
    doc: Number of interquartile ranges (IQRs) above or below the median to consider a value an outlier. Default is 1.5 IQRs.
    inputBinding:
      position: 102
      prefix: --iqrs
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Output prefix for writing files. Default outliers.
    inputBinding:
      position: 102
      prefix: --output_prefix
  - id: up_or_down
    type:
      - 'null'
      - string
    doc: Whether to look for up or down outliers. Choices are up or down. Default up.
    inputBinding:
      position: 102
      prefix: --up_or_down
  - id: write_frac_table
    type:
      - 'null'
      - boolean
    doc: Use flag if you want to write a table with fraction of values per site, per sample that are outliers. Will not be written by default. Useful for visualization.
    inputBinding:
      position: 102
      prefix: --write_frac_table
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
