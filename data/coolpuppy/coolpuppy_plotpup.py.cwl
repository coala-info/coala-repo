cwlVersion: v1.2
class: CommandLineTool
baseCommand: plotpup.py
label: coolpuppy_plotpup.py
doc: "Plot pileups from coolpuppy\n\nTool homepage: https://github.com/open2c/coolpuppy"
inputs:
  - id: center
    type:
      - 'null'
      - int
    doc: How many central pixels to consider when calculating enrichment for 
      off-diagonal pileups.
    default: 3
    inputBinding:
      position: 101
      prefix: --center
  - id: cmap
    type:
      - 'null'
      - string
    doc: Colormap to use (see https://matplotlib.org/users/colormaps.html)
    default: coolwarm
    inputBinding:
      position: 101
      prefix: --cmap
  - id: col_order
    type:
      - 'null'
      - string
    doc: Order of columns to use, space separated inside quotes
    default: None
    inputBinding:
      position: 101
      prefix: --col_order
  - id: colnames
    type:
      - 'null'
      - type: array
        items: string
    doc: Names to plot for columns, space separated.
    default: None
    inputBinding:
      position: 101
      prefix: --colnames
  - id: cols
    type:
      - 'null'
      - string
    doc: Which value to map as columns
    default: None
    inputBinding:
      position: 101
      prefix: --cols
  - id: divide_pups
    type:
      - 'null'
      - boolean
    doc: Whether to divide two pileups and plot the result
    inputBinding:
      position: 101
      prefix: --divide_pups
  - id: dpi
    type:
      - 'null'
      - int
    doc: DPI of the output plot. Try increasing if heatmaps look blurry
    default: 300
    inputBinding:
      position: 101
      prefix: --dpi
  - id: font
    type:
      - 'null'
      - string
    doc: Font to use for plotting
    default: DejaVu Sans
    inputBinding:
      position: 101
      prefix: --font
  - id: font_scale
    type:
      - 'null'
      - float
    doc: Font scale to use for plotting. Defaults to 1
    default: 1
    inputBinding:
      position: 101
      prefix: --font_scale
  - id: height
    type:
      - 'null'
      - float
    doc: Height of the plot
    default: 1
    inputBinding:
      position: 101
      prefix: --height
  - id: ignore_central
    type:
      - 'null'
      - int
    doc: How many central bins to ignore when calculating insulation for local 
      (on-diagonal) non-rescaled pileups.
    default: 3
    inputBinding:
      position: 101
      prefix: --ignore_central
  - id: input_pups
    type:
      - 'null'
      - type: array
        items: File
    doc: All files to plot
    default: None
    inputBinding:
      position: 101
      prefix: --input_pups
  - id: lineplot
    type:
      - 'null'
      - boolean
    doc: Whether to plot the average lineplot above stripes. This only works for
      a single plot, i.e. without rows/columns
    inputBinding:
      position: 101
      prefix: --lineplot
  - id: log_level
    type:
      - 'null'
      - string
    doc: Set the logging level
    default: INFO
    inputBinding:
      position: 101
      prefix: --log
  - id: no_score
    type:
      - 'null'
      - boolean
    doc: If central pixel score should not be shown in top left corner
    inputBinding:
      position: 101
      prefix: --no_score
  - id: norm_corners
    type:
      - 'null'
      - int
    doc: Whether to normalize pileups by their top left and bottom right 
      corners. 0 for no normalization, positive number to define the size of the
      corner squares whose values are averaged
    default: 0
    inputBinding:
      position: 101
      prefix: --norm_corners
  - id: not_symmetric
    type:
      - 'null'
      - boolean
    doc: Whether to **not** make colormap symmetric around 1, if log scale
    inputBinding:
      position: 101
      prefix: --not_symmetric
  - id: out_sorted_bedpe
    type:
      - 'null'
      - File
    doc: Output bedpe of sorted stripe regions
    default: None
    inputBinding:
      position: 101
      prefix: --out_sorted_bedpe
  - id: plot_ticks
    type:
      - 'null'
      - boolean
    doc: Whether to plot ticks demarkating the center and flanking regions, only
      applicable for non-stripes
    inputBinding:
      position: 101
      prefix: --plot_ticks
  - id: post_mortem
    type:
      - 'null'
      - boolean
    doc: Enter debugger if there is an error
    inputBinding:
      position: 101
      prefix: --post_mortem
  - id: quaich
    type:
      - 'null'
      - boolean
    doc: Activate if pileups are named accodring to Quaich naming convention to 
      get information from the file name
    inputBinding:
      position: 101
      prefix: --quaich
  - id: query
    type:
      - 'null'
      - string
    doc: "Pandas query to select pups to plot from concatenated input files. Multiple
      query arguments can be used. Usage example: --query \"orientation == '+-' |
      orientation == '-+'\""
    default: None
    inputBinding:
      position: 101
      prefix: --query
  - id: row_order
    type:
      - 'null'
      - string
    doc: Order of rows to use, space separated inside quotes
    default: None
    inputBinding:
      position: 101
      prefix: --row_order
  - id: rownames
    type:
      - 'null'
      - type: array
        items: string
    doc: Names to plot for rows, space separated.
    default: None
    inputBinding:
      position: 101
      prefix: --rownames
  - id: rows
    type:
      - 'null'
      - string
    doc: Which value to map as rows
    default: None
    inputBinding:
      position: 101
      prefix: --rows
  - id: scale
    type:
      - 'null'
      - string
    doc: Whether to use linear or log scaling for mapping colours
    default: log
    inputBinding:
      position: 101
      prefix: --scale
  - id: stripe
    type:
      - 'null'
      - string
    doc: For plotting stripe stackups
    default: None
    inputBinding:
      position: 101
      prefix: --stripe
  - id: stripe_sort
    type:
      - 'null'
      - string
    doc: Whether to sort stripe stackups by total signal (sum), central pixel 
      signal (center_pixel), or not at all (None)
    default: sum
    inputBinding:
      position: 101
      prefix: --stripe_sort
  - id: vmax
    type:
      - 'null'
      - float
    doc: Value for the highest colour
    default: None
    inputBinding:
      position: 101
      prefix: --vmax
  - id: vmin
    type:
      - 'null'
      - float
    doc: Value for the lowest colour
    default: None
    inputBinding:
      position: 101
      prefix: --vmin
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Where to save the plot
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/coolpuppy:1.1.0--pyh086e186_0
