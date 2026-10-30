cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - plot
  - sviol
label: scanpy-scripts_scanpy-cli_plot_sviol
doc: "Plot stacked violin plots.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs:
  - id: input_obj
    type: File
    doc: input file in format specified by --input-format
    inputBinding:
      position: 1
  - id: output_fig_path
    type: string
    doc: output figure in pdf or png format
    inputBinding:
      position: 2
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Input object format."
    inputBinding:
      position: 101
      prefix: --input-format
  - id: fig_size
    type:
      - 'null'
      - type: array
        items: int
    doc: "Figure size."
    inputBinding:
      position: 101
      prefix: --fig-size
      itemSeparator: ','
  - id: fig_dpi
    type:
      - 'null'
      - int
    doc: "Figure DPI."
    inputBinding:
      position: 101
      prefix: --fig-dpi
  - id: fig_fontsize
    type:
      - 'null'
      - int
    doc: "Figure font size."
    inputBinding:
      position: 101
      prefix: --fig-fontsize
  - id: use_raw
    type:
      - 'null'
      - boolean
    doc: "Use expression values in `.raw` if present. (--use-raw)"
    inputBinding:
      position: 101
      prefix: --use-raw
  - id: no_raw
    type:
      - 'null'
      - boolean
    doc: "Use expression values in `.raw` if present. (--no-raw)"
    inputBinding:
      position: 101
      prefix: --no-raw
  - id: var_names
    type:
      - 'null'
      - type: array
        items: string
    doc: "var_names should be a valid subset of adata.var_names."
    inputBinding:
      position: 101
      prefix: --var-names
      itemSeparator: ','
  - id: groups
    type:
      - 'null'
      - type: array
        items: string
    doc: "The groups for which to show the gene ranking."
    inputBinding:
      position: 101
      prefix: --groups
      itemSeparator: ','
  - id: n_genes
    type:
      - 'null'
      - int
    doc: "Number of genes to show."
    inputBinding:
      position: 101
      prefix: --n-genes
  - id: layer
    type:
      - 'null'
      - type: array
        items: string
    doc: "Name of the AnnData object layer that wants to be plotted. By default adata.raw.X is plotted. If use_raw=False is set, then adata.X is plotted. If layer is set to a valid layer name, then the layer is plotted. layer takes precedence over use_raw."
    inputBinding:
      position: 101
      prefix: --layer
      itemSeparator: ','
  - id: rgg
    type:
      - 'null'
      - boolean
    doc: "When set, use the rank_genes_groups_ form of the function, where gene lists are automatically selected."
    inputBinding:
      position: 101
      prefix: --rgg
  - id: groupby
    type:
      - 'null'
      - type: array
        items: string
    doc: "The key of the observation grouping to consider."
    inputBinding:
      position: 101
      prefix: --groupby
      itemSeparator: ','
  - id: log
    type:
      - 'null'
      - boolean
    doc: "Plot on logarithmic axis."
    inputBinding:
      position: 101
      prefix: --log
  - id: num_categories
    type:
      - 'null'
      - int
    doc: "Only used if groupby observation is not categorical. This value determines the number of groups into which the groupby observation should be subdivided."
    inputBinding:
      position: 101
      prefix: --num-categories
  - id: dendrogram
    type:
      - 'null'
      - boolean
    doc: "If True, a dendrogram based on the hierarchical clustering between the groupby categories is added. The dendrogram information is computed using scanpy.tl.dendrogram(). If tl.dendrogram has not been called previously the function is called with default parameters."
    inputBinding:
      position: 101
      prefix: --dendrogram
  - id: standard_scale
    type:
      - 'null'
      - string
    doc: "Whether or not to standardize that dimension between 0 and 1, meaning for each variable or group, subtract the minimum and divide each by its maximum."
    inputBinding:
      position: 101
      prefix: --standard-scale
  - id: gene_symbols
    type:
      - 'null'
      - type: array
        items: string
    doc: "Column name in .var DataFrame that stores gene symbols. By default this is assumed to be the index column of the .var DataFrame. Setting this option allows alternative names to be used."
    inputBinding:
      position: 101
      prefix: --gene-symbols
      itemSeparator: ','
  - id: no_stripplot
    type:
      - 'null'
      - boolean
    doc: "When set, do not add a stripplot on top of the violin plot."
    inputBinding:
      position: 101
      prefix: --no-stripplot
  - id: no_jitter
    type:
      - 'null'
      - boolean
    doc: "Suppress jitter in the stripplot (only when stripplot is True)"
    inputBinding:
      position: 101
      prefix: --no-jitter
  - id: size
    type:
      - 'null'
      - int
    doc: "Size of the jitter points."
    inputBinding:
      position: 101
      prefix: --size
  - id: order
    type:
      - 'null'
      - type: array
        items: string
    doc: "Order in which to show the categories."
    inputBinding:
      position: 101
      prefix: --order
      itemSeparator: ','
  - id: scale
    type:
      - 'null'
      - string
    doc: "The method used to scale the width of each violin. If ‘area’, each violin will have the same area. If ‘count’, the width of the violins will be scaled by the number of observations in that bin. If ‘width’, each violin will have the same width."
    inputBinding:
      position: 101
      prefix: --scale
  - id: row_palette
    type:
      - 'null'
      - type: array
        items: string
    doc: "The row palette determines the colors to use in each of the stacked violin plots. The value should be a valid seaborn palette name or a valic matplotlib colormap (see https:// seaborn.pydata.org/generated/seaborn.color_p alette.html). Alternatively, a single color name or hex value can be passed. E.g. ‘red’ or ‘#cc33ff’."
    inputBinding:
      position: 101
      prefix: --row-palette
      itemSeparator: ','
  - id: swap_axes
    type:
      - 'null'
      - boolean
    doc: "By default, the x axis contains var_names (e.g. genes) and the y axis the groupby categories. By setting swap_axes then x are the groupby categories and y the var_names. When swapping axes var_group_positions are no longer used."
    inputBinding:
      position: 101
      prefix: --swap-axes
outputs:
  - id: output_fig
    type: File
    doc: output figure
    outputBinding:
      glob: $(inputs.output_fig_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
