cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-plot.R
label: seurat-scripts_seurat-plot.R
doc: 'Make a Seurat plot (FeaturePlot, RidgePlot, DimPlot, VlnPlot or DotPlot) and save it to a file.


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: Query file with Seurat object in either RDS-Seurat, Loom or SCE
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: plot_out
    type: string
    doc: File name to create on disk.
    inputBinding:
      position: 2
      prefix: --plot-out=
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
  - id: plot_type
    type:
      - 'null'
      - string
    doc: Either FeaturePlot, RidgePlot, DimPlot, VlnPlot or DotPlot.
    inputBinding:
      position: 4
      prefix: --plot-type=
      separate: false
  - id: dims
    type:
      - 'null'
      - string
    doc: Dimensions to plot, must be a two-length numeric vector specifying x- and y-dimensions
    inputBinding:
      position: 5
      prefix: --dims=
      separate: false
  - id: cells
    type:
      - 'null'
      - string
    doc: Vector of cells to plot (default is all cells)
    inputBinding:
      position: 6
      prefix: --cells=
      separate: false
  - id: cols
    type:
      - 'null'
      - string
    doc: Vector of colors, each color corresponds to an identity class. This may also be a single character or numeric value corresponding to a palette as specified by brewer.pal.info. By default, ggplot2 assigns colors. We also include a number of palettes from the pals package. See 'DiscretePalette' for details.
    inputBinding:
      position: 7
      prefix: --cols=
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
  - id: reduction
    type:
      - 'null'
      - string
    doc: Which dimensionality reduction to use. If not specified, first searches for umap, then tsne, then pca
    inputBinding:
      position: 9
      prefix: --reduction=
      separate: false
  - id: group_by
    type:
      - 'null'
      - string
    doc: Name of one or more metadata columns to group (color) cells by (for example, orig.ident); pass 'ident' to group by identity class
    inputBinding:
      position: 10
      prefix: --group-by=
      separate: false
  - id: split_by
    type:
      - 'null'
      - string
    doc: Name of a metadata column to split plot by; see 'FetchData' for more details
    inputBinding:
      position: 11
      prefix: --split-by=
      separate: false
  - id: shape_by
    type:
      - 'null'
      - string
    doc: If NULL, all points are circles (default). You can specify any cell attribute (that can be pulled with FetchData) allowing for both different colors and different shapes on cells. Only applicable if raster is FALSE.
    inputBinding:
      position: 12
      prefix: --shape-by=
      separate: false
  - id: order
    type:
      - 'null'
      - string
    doc: Specify the order of plotting for the idents. This can be useful for crowded plots if points of interest are being buried. Provide either a full list of valid idents or a subset to be plotted last (on top)
    inputBinding:
      position: 13
      prefix: --order=
      separate: false
  - id: shuffle
    type:
      - 'null'
      - boolean
    doc: Whether to randomly shuffle the order of points. This can be useful for crowded plots if points of interest are being buried. (default is FALSE)
    inputBinding:
      position: 14
      prefix: --shuffle
  - id: seed
    type:
      - 'null'
      - int
    doc: Sets the seed if randomly shuffling the order of points.
    inputBinding:
      position: 15
      prefix: --seed=
      separate: false
  - id: label
    type:
      - 'null'
      - boolean
    doc: Whether to label the clusters
    inputBinding:
      position: 16
      prefix: --label
  - id: label_size
    type:
      - 'null'
      - int
    doc: Sets size of labels
    inputBinding:
      position: 17
      prefix: --label-size=
      separate: false
  - id: label_color
    type:
      - 'null'
      - string
    doc: Sets the color of the label text
    inputBinding:
      position: 18
      prefix: --label-color=
      separate: false
  - id: label_box
    type:
      - 'null'
      - boolean
    doc: Whether to put a box around the label text (geom_text vs geom_label)
    inputBinding:
      position: 19
      prefix: --label-box
  - id: repel
    type:
      - 'null'
      - boolean
    doc: Repel labels
    inputBinding:
      position: 20
      prefix: --repel
  - id: cells_highlight
    type:
      - 'null'
      - string
    doc: A list of character or numeric vectors of cells to highlight. If only one group of cells desired, can simply pass a vector instead of a list. If set, colors selected cells to the color(s) in 'cols.highlight' and other cells black (white if dark.theme = TRUE); will also resize to the size(s) passed to 'sizes.highlight'.
    inputBinding:
      position: 21
      prefix: --cells-highlight=
      separate: false
  - id: cols_highlight
    type:
      - 'null'
      - string
    doc: A vector of colors to highlight the cells as; will repeat to the length groups in cells.highlight. Comma separated.
    inputBinding:
      position: 22
      prefix: --cols-highlight=
      separate: false
  - id: sizes_highlight
    type:
      - 'null'
      - int
    doc: Size of highlighted cells; will repeat to the length groups in cells.highlight
    inputBinding:
      position: 23
      prefix: --sizes-highlight=
      separate: false
  - id: na_value
    type:
      - 'null'
      - string
    doc: Color value for NA points when using custom scale
    inputBinding:
      position: 24
      prefix: --na-value=
      separate: false
  - id: ncol
    type:
      - 'null'
      - int
    doc: Number of columns for display when combining plots
    inputBinding:
      position: 25
      prefix: --ncol=
      separate: false
  - id: features
    type:
      - 'null'
      - string
    doc: A vector of features to plot, defaults to VariableFeatures of the object.
    inputBinding:
      position: 26
      prefix: --features=
      separate: false
  - id: do_not_group_bar
    type:
      - 'null'
      - boolean
    doc: Add a color bar showing group status for cells
    inputBinding:
      position: 27
      prefix: --do-not-group-bar
  - id: group_colors
    type:
      - 'null'
      - string
    doc: Colors to use for the color bar, comma separated.
    inputBinding:
      position: 28
      prefix: --group-colors=
      separate: false
  - id: disp_min
    type:
      - 'null'
      - int
    doc: Minimum display value (all values below are clipped)
    inputBinding:
      position: 29
      prefix: --disp-min=
      separate: false
  - id: disp_max
    type:
      - 'null'
      - int
    doc: Maximum display value (all values above are clipped); defaults to 2.5 if slot is 'scale.data', 6 otherwise
    inputBinding:
      position: 30
      prefix: --disp-max=
      separate: false
  - id: slot
    type:
      - 'null'
      - string
    doc: Data slot to use, choose from raw.data, data, or scale.data
    inputBinding:
      position: 31
      prefix: --slot=
      separate: false
  - id: assay
    type:
      - 'null'
      - string
    doc: Assay to pull from
    inputBinding:
      position: 32
      prefix: --assay=
      separate: false
  - id: do_not_label
    type:
      - 'null'
      - boolean
    doc: Label the cell identies above the color bar
    inputBinding:
      position: 33
      prefix: --do-not-label
  - id: size
    type:
      - 'null'
      - int
    doc: Size of text above color bar
    inputBinding:
      position: 34
      prefix: --size=
      separate: false
  - id: hjust
    type:
      - 'null'
      - int
    doc: Horizontal justification of text above color bar
    inputBinding:
      position: 35
      prefix: --hjust=
      separate: false
  - id: angle
    type:
      - 'null'
      - int
    doc: Angle of text above color bar
    inputBinding:
      position: 36
      prefix: --angle=
      separate: false
  - id: do_not_raster
    type:
      - 'null'
      - boolean
    doc: If true, plot with geom_raster, else use geom_tile. geom_raster may look blurry on some viewing applications such as Preview due to how the raster is interpolated. Set this to FALSE if you are encountering that issue (note that plots may take longer to produce/render).
    inputBinding:
      position: 37
      prefix: --do-not-raster
  - id: do_not_draw_lines
    type:
      - 'null'
      - boolean
    doc: Include white lines to separate the groups
    inputBinding:
      position: 38
      prefix: --do-not-draw-lines
  - id: lines_width
    type:
      - 'null'
      - int
    doc: Integer number to adjust the width of the separating white lines. Corresponds to the number of cells between each group.
    inputBinding:
      position: 39
      prefix: --lines-width=
      separate: false
  - id: group_bar_height
    type:
      - 'null'
      - int
    doc: Scale the height of the color bar
    inputBinding:
      position: 40
      prefix: --group-bar-height=
      separate: false
  - id: do_not_combine
    type:
      - 'null'
      - boolean
    doc: Combine plots into a single patchwork or ed ggplot object. If FALSE return a list of ggplot objects.
    inputBinding:
      position: 41
      prefix: --do-not-combine
  - id: cols_ridgeplot
    type:
      - 'null'
      - string
    doc: Colors to use for plotting, comma separated
    inputBinding:
      position: 42
      prefix: --cols-ridgeplot=
      separate: false
  - id: idents
    type:
      - 'null'
      - string
    doc: Which classes to include in the plot (default is all)
    inputBinding:
      position: 43
      prefix: --idents=
      separate: false
  - id: sort
    type:
      - 'null'
      - boolean
    doc: Sort identity classes (on the x-axis) by the average expression of the attribute being potted, can also pass 'increasing' or 'decreasing' to change sort direction
    inputBinding:
      position: 44
      prefix: --sort
  - id: y_max
    type:
      - 'null'
      - float
    doc: Maximum y axis value
    inputBinding:
      position: 45
      prefix: --y-max=
      separate: false
  - id: same_y_lims
    type:
      - 'null'
      - boolean
    doc: Set all the y-axis limits to the same values
    inputBinding:
      position: 46
      prefix: --same-y-lims
  - id: log
    type:
      - 'null'
      - boolean
    doc: plot the feature axis on log scale
    inputBinding:
      position: 47
      prefix: --log
  - id: stack
    type:
      - 'null'
      - boolean
    doc: Horizontally stack plots for each feature
    inputBinding:
      position: 48
      prefix: --stack
  - id: fill_by
    type:
      - 'null'
      - string
    doc: Color violins/ridges based on either 'feature' or 'ident'
    inputBinding:
      position: 49
      prefix: --fill-by=
      separate: false
  - id: cols_feature_plot
    type:
      - 'null'
      - string
    doc: The two colors to form the gradient over. Provide as string vector with the first color corresponding to low values, the second to high. Also accepts a Brewer color scale or vector of colors.
    inputBinding:
      position: 50
      prefix: --cols-feature-plot=
      separate: false
  - id: min_cutoff
    type:
      - 'null'
      - string
    doc: Vector of minimum cutoff values for each feature, may specify quantile in the form of 'q##' where '##' is the quantile (eg, 'q1', 'q10')
    inputBinding:
      position: 51
      prefix: --min-cutoff=
      separate: false
  - id: max_cutoff
    type:
      - 'null'
      - string
    doc: Vector of maximum cutoff values for each feature, may specify quantile in the form of 'q##' where '##' is the quantile (eg, 'q1', 'q10')
    inputBinding:
      position: 52
      prefix: --max-cutoff=
      separate: false
  - id: keep_scale
    type:
      - 'null'
      - string
    doc: How to handle the color scale across multiple plots.
    inputBinding:
      position: 53
      prefix: --keep-scale=
      separate: false
  - id: blend
    type:
      - 'null'
      - boolean
    doc: Scale and blend expression values to visualize coexpression of two features
    inputBinding:
      position: 54
      prefix: --blend
  - id: blend_threshold
    type:
      - 'null'
      - int
    doc: The color cutoff from weak signal to strong signal; ranges from 0 to 1.
    inputBinding:
      position: 55
      prefix: --blend-threshold=
      separate: false
  - id: coord_fixed
    type:
      - 'null'
      - boolean
    doc: Plot cartesian coordinates with fixed aspect ratio
    inputBinding:
      position: 56
      prefix: --coord-fixed
  - id: do_not_by_col
    type:
      - 'null'
      - boolean
    doc: If splitting by a factor, plot the splits per column with the features as rows; ignored if blend = TRUE.
    inputBinding:
      position: 57
      prefix: --do-not-by-col
  - id: adjust
    type:
      - 'null'
      - int
    doc: Adjust parameter for geom_violin
    inputBinding:
      position: 58
      prefix: --adjust=
      separate: false
  - id: split_plot
    type:
      - 'null'
      - boolean
    doc: plot each group of the split violin plots by multiple or single violin shapes.
    inputBinding:
      position: 59
      prefix: --split-plot
  - id: flip
    type:
      - 'null'
      - boolean
    doc: flip plot orientation (identities on x-axis)
    inputBinding:
      position: 60
      prefix: --flip
  - id: cols_dot_plot
    type:
      - 'null'
      - string
    doc: 'Colors to plot: the name of a palette from RColorBrewer::brewer.pal.info , a pair of colors defining a gradient, or 3+ colors defining multiple gradients (if split.by is set)'
    inputBinding:
      position: 61
      prefix: --cols-dot-plot=
      separate: false
  - id: col_min
    type:
      - 'null'
      - int
    doc: Minimum scaled average expression threshold (everything smaller will be set to this)
    inputBinding:
      position: 62
      prefix: --col-min=
      separate: false
  - id: col_max
    type:
      - 'null'
      - int
    doc: Maximum scaled average expression threshold (everything larger will be set to this)
    inputBinding:
      position: 63
      prefix: --col-max=
      separate: false
  - id: dot_min
    type:
      - 'null'
      - int
    doc: The fraction of cells at which to draw the smallest dot (default is 0). All cell groups with less than this expressing the given gene will have no dot drawn.
    inputBinding:
      position: 64
      prefix: --dot-min=
      separate: false
  - id: dot_scale
    type:
      - 'null'
      - int
    doc: Scale the size of the points, similar to cex
    inputBinding:
      position: 65
      prefix: --dot-scale=
      separate: false
  - id: cluster_idents
    type:
      - 'null'
      - boolean
    doc: Whether to order identities by hierarchical clusters based on given features, default is FALSE
    inputBinding:
      position: 66
      prefix: --cluster-idents
  - id: do_not_scale
    type:
      - 'null'
      - boolean
    doc: Determine whether the data is scaled, will be done by default
    inputBinding:
      position: 67
      prefix: --do-not-scale
  - id: scale_by
    type:
      - 'null'
      - string
    doc: Scale the size of the points by 'size' or by 'radius'
    inputBinding:
      position: 68
      prefix: --scale-by=
      separate: false
  - id: scale_min
    type:
      - 'null'
      - float
    doc: Set lower limit for scaling, use NA for default
    inputBinding:
      position: 69
      prefix: --scale-min=
      separate: false
  - id: scale_max
    type:
      - 'null'
      - float
    doc: Set upper limit for scaling, use NA for default
    inputBinding:
      position: 70
      prefix: --scale-max=
      separate: false
  - id: output_rds_file
    type:
      - 'null'
      - string
    doc: Path to RDS to keep the plot object
    inputBinding:
      position: 71
      prefix: --output-rds-file=
      separate: false
  - id: plot_format
    type:
      - 'null'
      - string
    doc: Format to use, either PNG, EPS, PostScript, TeX, PDF, JPEG, TIFF or SVG
    inputBinding:
      position: 72
      prefix: --plot-format=
      separate: false
  - id: scale_factor
    type:
      - 'null'
      - float
    doc: Multiplicative scaling factor.
    inputBinding:
      position: 73
      prefix: --scale-factor=
      separate: false
  - id: width
    type:
      - 'null'
      - float
    doc: Width of the figure, in the selected units.
    inputBinding:
      position: 74
      prefix: --width=
      separate: false
  - id: height
    type:
      - 'null'
      - float
    doc: Height of the figure, in the selected units.
    inputBinding:
      position: 75
      prefix: --height=
      separate: false
  - id: units
    type:
      - 'null'
      - string
    doc: Units for the plot dimensions.
    inputBinding:
      position: 76
      prefix: --units=
      separate: false
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'Plot resolution. Also accepts a string input: retina (320), print (300), or screen (72). Applies only to raster output types.'
    inputBinding:
      position: 77
      prefix: --dpi=
      separate: false
  - id: do_not_limitsize
    type:
      - 'null'
      - boolean
    doc: When TRUE (the default) ggsave() will not save images larger than 50x50 inches, to prevent the common error of specifying dimensions in pixels.
    inputBinding:
      position: 78
      prefix: --do-not-limitsize
  - id: bg
    type:
      - 'null'
      - string
    doc: Background colour. If NULL, uses the plot.background fill value from the plot theme.
    inputBinding:
      position: 79
      prefix: --bg=
      separate: false
outputs:
  - id: plot_out
    type: File
    doc: File name to create on disk.
    outputBinding:
      glob: $(inputs.plot_out)
  - id: output_rds_file
    type:
      - 'null'
      - File
    doc: Path to RDS to keep the plot object
    outputBinding:
      glob: $(inputs.output_rds_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
