cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - plot
  - dot
label: scanpy-scripts_scanpy-cli_plot_dot
doc: "Plot a dot plot of expression values.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: expression_cutoff
    type:
      - 'null'
      - float
    doc: "Expression cutoff that is used for binarizing the gene expression and determining the fraction of cells expressing given genes. A gene is expressed only if the expression value is greater than this threshold."
    inputBinding:
      position: 101
      prefix: --expression-cutoff
  - id: mean_only_expressed
    type:
      - 'null'
      - boolean
    doc: "If True, gene expression is averaged only over the cells expressing the given genes."
    inputBinding:
      position: 101
      prefix: --mean-only-expressed
  - id: color_map
    type:
      - 'null'
      - type: array
        items: string
    doc: "String denoting matplotlib color map."
    inputBinding:
      position: 101
      prefix: --color-map
      itemSeparator: ','
  - id: dot_max
    type:
      - 'null'
      - float
    doc: "If none, the maximum dot size is set to the maximum fraction value found (e.g. 0.6). If given, the value should be a number between 0 and 1. All fractions larger than dot_max are clipped to this value."
    inputBinding:
      position: 101
      prefix: --dot-max
  - id: dot_min
    type:
      - 'null'
      - float
    doc: "If none, the minimum dot size is set to 0. If given, the value should be a number between 0 and 1. All fractions smaller than dot_min are clipped to this value."
    inputBinding:
      position: 101
      prefix: --dot-min
  - id: smallest_dot
    type:
      - 'null'
      - float
    doc: "If none, the smallest dot has size 0. All expression levels with dot_min are potted with smallest_dot dot size."
    inputBinding:
      position: 101
      prefix: --smallest-dot
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
