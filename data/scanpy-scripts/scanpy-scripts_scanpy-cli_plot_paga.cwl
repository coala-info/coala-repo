cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - plot
  - paga
label: scanpy-scripts_scanpy-cli_plot_paga
doc: "Plot PAGA trajectories.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: random_state
    type:
      - 'null'
      - int
    doc: "Seed for random number generator."
    inputBinding:
      position: 101
      prefix: --random-state
  - id: use_key
    type:
      - 'null'
      - string
    doc: "The key in `.uns` that contains trajectory information."
    inputBinding:
      position: 101
      prefix: --use-key
  - id: layout
    type:
      - 'null'
      - string
    doc: "Plotting layout that computes positions."
    inputBinding:
      position: 101
      prefix: --layout
  - id: init_pos
    type:
      - 'null'
      - string
    doc: "Plotting layout that computes positions."
    inputBinding:
      position: 101
      prefix: --init-pos
  - id: threshold
    type:
      - 'null'
      - float
    doc: "Do not draw edges for weights below this threshold. Set to 0 to include all edges."
    inputBinding:
      position: 101
      prefix: --threshold
  - id: root
    type:
      - 'null'
      - int
    doc: "If choosing a tree layout, this is the index of the root node."
    inputBinding:
      position: 101
      prefix: --root
  - id: transitions
    type:
      - 'null'
      - string
    doc: "Key for `.uns[\"paga\"]` that specifies the matrix, e.g. `transition_confidence`, that stores the arrows."
    inputBinding:
      position: 101
      prefix: --transitions
  - id: single_component
    type:
      - 'null'
      - boolean
    doc: "Restrict to largest connected component"
    inputBinding:
      position: 101
      prefix: --single-component
  - id: solid_edges
    type:
      - 'null'
      - string
    doc: "Key for `.uns[\"paga\"]` that specifies the matrix that stores the edges to be drawn solid black."
    inputBinding:
      position: 101
      prefix: --solid-edges
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
    doc: "Key(s) for annotation of observations/cells or variables/genes. Comma-separated if more than one"
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
  - id: size
    type:
      - 'null'
      - float
    doc: "Point size. Automatically computed if not specified."
    inputBinding:
      position: 101
      prefix: --size
  - id: node_size_scale
    type:
      - 'null'
      - float
    doc: "Increase of decrease the size of the nodes."
    inputBinding:
      position: 101
      prefix: --node-size-scale
  - id: fontsize
    type:
      - 'null'
      - int
    doc: "Font size for node labels."
    inputBinding:
      position: 101
      prefix: --fontsize
  - id: edge_width_scale
    type:
      - 'null'
      - float
    doc: "Increase of decrease the width of the edges."
    inputBinding:
      position: 101
      prefix: --edge-width-scale
  - id: arrowsize
    type:
      - 'null'
      - int
    doc: "For directed graphs, specify the length and width of the arrowhead."
    inputBinding:
      position: 101
      prefix: --arrowsize
  - id: output_obj_path
    type:
      - 'null'
      - string
    doc: "Optionally output an object to the specified path."
    inputBinding:
      position: 101
      prefix: --output-obj
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output object format."
    inputBinding:
      position: 101
      prefix: --output-format
  - id: zarr_chunk_size
    type:
      - 'null'
      - int
    doc: "Chunk size for writing output in zarr format."
    inputBinding:
      position: 101
      prefix: --zarr-chunk-size
  - id: loom_write_obsm_varm
    type:
      - 'null'
      - boolean
    doc: "Write obsm and varm to the Loom file?"
    inputBinding:
      position: 101
      prefix: --loom-write-obsm-varm
  - id: export_mtx_path
    type:
      - 'null'
      - string
    doc: "When specified, using it as prefix for exporting mtx files. If not empty and not ending with \"/\" or \"_\", a \"_\" will be appended."
    inputBinding:
      position: 101
      prefix: --export-mtx
  - id: mtx_compression
    type:
      - 'null'
      - string
    doc: "Compression type for MTX output."
    inputBinding:
      position: 101
      prefix: --mtx-compression
  - id: show_obj
    type:
      - 'null'
      - string
    doc: "Print output object summary info to specified stream."
    inputBinding:
      position: 101
      prefix: --show-obj
outputs:
  - id: output_fig
    type: File
    doc: output figure
    outputBinding:
      glob: $(inputs.output_fig_path)
  - id: output_obj
    type:
      - 'null'
      - File
    doc: "Optionally output an object to the specified path."
    outputBinding:
      glob: $(inputs.output_obj_path)
  - id: export_mtx
    type:
      type: array
      items: File
    doc: "When specified, using it as prefix for exporting mtx files. If not empty and not ending with \"/\" or \"_\", a \"_\" will be appended. (files written with the given prefix)"
    outputBinding:
      glob: $(inputs.export_mtx_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
