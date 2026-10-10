cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - monocle3
  - plotCells
label: monocle3-cli_plotCells
doc: "Visualise trajectories.\n\nTool homepage: https://github.com/ebi-gene-expression-group/monocle-scripts"
inputs:
  - id: input_object
    type: File
    doc: "Input object, CellDataSet V3 (cds3) as an RDS file. Only cds3 is supported currently."
    inputBinding:
      position: 1
  - id: output_plot
    type: string
    doc: "Output plot file name."
    inputBinding:
      position: 2
  - id: input_object_format
    type:
      - 'null'
      - string
    doc: "Format of input object. [Default: cds3]"
    inputBinding:
      position: 103
      prefix: -f
  - id: output_plot_format
    type:
      - 'null'
      - string
    doc: "Format of output plot, choose from {png, pdf}. [Default: png]"
    inputBinding:
      position: 103
      prefix: -F
  - id: xdim
    type:
      - 'null'
      - int
    doc: "The column of reducedDimS(cds) to plot on the horizontal axis. [Default: 1]"
    inputBinding:
      position: 103
      prefix: --xdim
  - id: ydim
    type:
      - 'null'
      - int
    doc: "The column of reducedDimS(cds) to plot on the vertical axis. [Default: 2]"
    inputBinding:
      position: 103
      prefix: --ydim
  - id: reduction_method
    type:
      - 'null'
      - string
    doc: "The dimensionality reduction for plotting, choose from {UMAP, tSNE, PCA, LSI}. [Default: UMAP]"
    inputBinding:
      position: 103
      prefix: --reduction-method
  - id: color_cells_by
    type:
      - 'null'
      - string
    doc: "The cell attribute (e.g. the column of pData(cds)) to map to each cell's color, or one of {clusters, partitions, pseudotime}. [Default: pseudotime]"
    inputBinding:
      position: 103
      prefix: --color-cells-by
  - id: genes
    type:
      - 'null'
      - string
    doc: "A comma-separated list of gene IDs/short names to plot, one per panel."
    inputBinding:
      position: 103
      prefix: --genes
  - id: norm_method
    type:
      - 'null'
      - string
    doc: "Determines how to transform expression values for plotting, choose from {log, size_only}. [Default: log]"
    inputBinding:
      position: 103
      prefix: --norm-method
  - id: cell_size
    type:
      - 'null'
      - float
    doc: "The size of the point for each cell. [Default: 1.5]"
    inputBinding:
      position: 103
      prefix: --cell-size
  - id: alpha
    type:
      - 'null'
      - float
    doc: "The alpha aesthetics for the original cell points, useful to highlight the learned principal graph."
    inputBinding:
      position: 103
      prefix: --alpha
  - id: label_cell_groups
    type:
      - 'null'
      - boolean
    doc: "If set, display the cell group names directly on the plot. Otherwise include a color legend on the side of the plot."
    inputBinding:
      position: 103
      prefix: --label-cell-groups
  - id: no_trajectory_graph
    type:
      - 'null'
      - boolean
    doc: "When this option is set, skip displaying the trajectory graph inferred by learn_graph()."
    inputBinding:
      position: 103
      prefix: --no-trajectory-graph
  - id: label_groups_by_cluster
    type:
      - 'null'
      - boolean
    doc: "If set, and setting --color-cells-by to something other than cluster, label the cells of each cluster independently. Can result in duplicate labels being present in the manifold."
    inputBinding:
      position: 103
      prefix: --label-groups-by-cluster
  - id: label_leaves
    type:
      - 'null'
      - boolean
    doc: "If set, label the leaves of the principal graph."
    inputBinding:
      position: 103
      prefix: --label-leaves
  - id: label_roots
    type:
      - 'null'
      - boolean
    doc: "If set, label the roots of the principal graph."
    inputBinding:
      position: 103
      prefix: --label-roots
  - id: label_branch_points
    type:
      - 'null'
      - boolean
    doc: "If set, label the branch points of the principal graph."
    inputBinding:
      position: 103
      prefix: --label-branch-points
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "Emit verbose output."
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_plot
    type: File
    doc: "Output plot"
    outputBinding:
      glob: $(inputs.output_plot)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/monocle3-cli:0.0.9--r36_1
