cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-dim-plot.R
label: seurat-scripts_seurat-dim-plot.R
doc: 'Plot a dimensionality reduction (PCA, tSNE, UMAP) of a Seurat object (Seurat DimPlot).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_image_file
    type: string
    doc: File name in which to save the PCA image
    inputBinding:
      position: 2
      prefix: --output-image-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 3
      prefix: --input-format=
      separate: false
  - id: reduction_use
    type:
      - 'null'
      - string
    doc: Which dimensionality reduction to use. Default is "umap", can also be "tsne", or "pca", assuming these are precomputed.
    inputBinding:
      position: 4
      prefix: --reduction-use=
      separate: false
  - id: dim_1
    type:
      - 'null'
      - int
    doc: Dimension for x-axis (default 1)
    inputBinding:
      position: 5
      prefix: --dim-1=
      separate: false
  - id: dim_2
    type:
      - 'null'
      - int
    doc: Dimension for y-axis (default 2)
    inputBinding:
      position: 6
      prefix: --dim-2=
      separate: false
  - id: cells_use
    type:
      - 'null'
      - File
    doc: File to be used to derive a vector of cells to plot (default is all cells).
    inputBinding:
      position: 7
      prefix: --cells-use=
      separate: false
  - id: pt_size
    type:
      - 'null'
      - int
    doc: Adjust point size for plotting
    inputBinding:
      position: 8
      prefix: --pt-size=
      separate: false
  - id: label_size
    type:
      - 'null'
      - int
    doc: Sets size of labels.
    inputBinding:
      position: 9
      prefix: --label-size=
      separate: false
  - id: do_label
    type:
      - 'null'
      - string
    doc: Whether to label the clusters.
    inputBinding:
      position: 10
      prefix: --do-label=
      separate: false
  - id: repel
    type:
      - 'null'
      - string
    doc: Repel labels.
    inputBinding:
      position: 11
      prefix: --repel=
      separate: false
  - id: group_by
    type:
      - 'null'
      - string
    doc: Group (color) cells in different ways (for example, orig.ident).
    inputBinding:
      position: 12
      prefix: --group-by=
      separate: false
  - id: cols_use
    type:
      - 'null'
      - string
    doc: Comma-separated list of colors, each color corresponds to an identity class. By default, ggplot assigns colors.
    inputBinding:
      position: 13
      prefix: --cols-use=
      separate: false
  - id: pt_shape
    type:
      - 'null'
      - string
    doc: If NULL, all points are circles (default). You can specify any cell attribute (that can be pulled with FetchData) allowing for both different colors and different shapes on cells.
    inputBinding:
      position: 14
      prefix: --pt-shape=
      separate: false
  - id: plot_order
    type:
      - 'null'
      - string
    doc: Comma-separated string specifying the order of plotting for the idents (clusters). This can be useful for crowded plots if points of interest are being buried. Provide either a full list of valid idents or a subset to be plotted last (on top)..
    inputBinding:
      position: 15
      prefix: --plot-order=
      separate: false
  - id: png_width
    type:
      - 'null'
      - int
    doc: Width of png (px).
    inputBinding:
      position: 16
      prefix: --png-width=
      separate: false
  - id: png_height
    type:
      - 'null'
      - int
    doc: Height of png file (px).
    inputBinding:
      position: 17
      prefix: --png-height=
      separate: false
outputs:
  - id: output_image_file
    type: File
    doc: File name in which to save the PCA image
    outputBinding:
      glob: $(inputs.output_image_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
