cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - plot
  - embed
label: scanpy-scripts_scanpy-cli_plot_embed
doc: "Plot cell embeddings.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
        items: string
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
  - id: frameon
    type:
      - 'null'
      - boolean
    doc: "Draw a frame around the plot (--frameon)"
    inputBinding:
      position: 101
      prefix: --frameon
  - id: frameoff
    type:
      - 'null'
      - boolean
    doc: "Draw a frame around the plot (--frameoff)"
    inputBinding:
      position: 101
      prefix: --frameoff
  - id: title
    type:
      - 'null'
      - type: array
        items: string
    doc: "Provide title for the plot or panels."
    inputBinding:
      position: 101
      prefix: --title
      itemSeparator: ','
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
  - id: basis
    type:
      - 'null'
      - string
    doc: "Name of the embedding to plot, must be a key of `.obsm` without the prefix \"X_\"."
    inputBinding:
      position: 101
      prefix: --basis
  - id: color
    type:
      - 'null'
      - type: array
        items: string
    doc: "Keys for annotations of observations/cells or variables/genes."
    inputBinding:
      position: 101
      prefix: --color
      itemSeparator: ','
  - id: legend_loc
    type:
      - 'null'
      - string
    doc: "Location of legend, either \"on data\", \"right margin\" or valid keywords for `matplotlib.legend`."
    inputBinding:
      position: 101
      prefix: --legend-loc
  - id: legend_fontsize
    type:
      - 'null'
      - int
    doc: "Legend font size."
    inputBinding:
      position: 101
      prefix: --legend-fontsize
  - id: size
    type:
      - 'null'
      - float
    doc: "Point size. Automatically computed if not specified."
    inputBinding:
      position: 101
      prefix: --size
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
  - id: edges
    type:
      - 'null'
      - boolean
    doc: "Show edges."
    inputBinding:
      position: 101
      prefix: --edges
  - id: edges_width
    type:
      - 'null'
      - float
    doc: "Width of edges."
    inputBinding:
      position: 101
      prefix: --edges-width
  - id: edges_color
    type:
      - 'null'
      - string
    doc: "Color of edges. See draw_networkx_edges()."
    inputBinding:
      position: 101
      prefix: --edges-color
  - id: neighbors_key
    type:
      - 'null'
      - string
    doc: "If not specified, look in .uns[‘neighbors’] for neighbors settings and .obsp[‘connectivities’], .obsp[‘distances’] for connectivities and distances respectively (default storage places for pp.neighbors). If specified, look in .uns[neighbors_key] for neighbors settings and .obsp[.uns[neighbors_key][‘connectivitie s_key’]], .obsp[.uns[neighbors_key][‘distances_key’]] for connectivities and distances respectively."
    inputBinding:
      position: 101
      prefix: --neighbors-key
  - id: no_sort_order
    type:
      - 'null'
      - boolean
    doc: "Disable default behaviour: for continuous annotations used as color parameter, plot data points with higher values on top of others."
    inputBinding:
      position: 101
      prefix: --no-sort-order
  - id: use_raw
    type:
      - 'null'
      - boolean
    doc: "Use `.raw` attribute for coloring with gene expression. If `None`, uses `.raw` if present. (--use-raw)"
    inputBinding:
      position: 101
      prefix: --use-raw
  - id: no_raw
    type:
      - 'null'
      - boolean
    doc: "Use `.raw` attribute for coloring with gene expression. If `None`, uses `.raw` if present. (--no-raw)"
    inputBinding:
      position: 101
      prefix: --no-raw
  - id: groups
    type:
      - 'null'
      - string
    doc: "Key for categorical in `.obs`. You can pass your predefined groups by choosing any categorical annotation of observations."
    inputBinding:
      position: 101
      prefix: --groups
  - id: components
    type:
      - 'null'
      - string
    doc: "For instance, ['1,2', '2,3']. To plot all available components use 'all'."
    inputBinding:
      position: 101
      prefix: --components
  - id: projection
    type:
      - 'null'
      - string
    doc: "Projection of plot."
    inputBinding:
      position: 101
      prefix: --projection
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
