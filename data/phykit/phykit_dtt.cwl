cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - dtt
label: phykit_dtt
doc: Disparity through time (DTT) analysis. Computes how morphological disparity
  partitions among subclades through time (Harmon et al. 2003).
inputs:
  - id: tree
    type: File
    doc: ultrametric tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: traits
    type:
      - 'null'
      - File
    doc: TSV file with trait data
    inputBinding:
      position: 101
      prefix: --traits
  - id: trait
    type:
      - 'null'
      - string
    doc: 'specific trait column name (default: all traits)'
    inputBinding:
      position: 101
      prefix: --trait
  - id: index
    type:
      - 'null'
      - string
    doc: 'disparity index: avg_sq (average squared Euclidean distance, default) or
      avg_manhattan'
    inputBinding:
      position: 101
      prefix: --index
  - id: nsim
    type:
      - 'null'
      - int
    doc: 'number of BM simulations for null DTT envelope and MDI p-value (default:
      0, no simulations)'
    inputBinding:
      position: 101
      prefix: --nsim
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: plot_output
    type: string
    doc: output figure path
    inputBinding:
      position: 101
      prefix: --plot-output
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
    inputBinding:
      position: 101
      prefix: --json
  - id: fig_width
    type:
      - 'null'
      - float
    doc: Figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: Figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: Resolution in DPI
    inputBinding:
      position: 101
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: Hide the plot title
    inputBinding:
      position: 101
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: Custom title text
    inputBinding:
      position: 101
      prefix: --title
  - id: legend_position
    type:
      - 'null'
      - string
    doc: Legend location (e.g., 'upper right', 'none' to hide)
    inputBinding:
      position: 101
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - int
    doc: Font size for y-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - int
    doc: Font size for x-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - int
    doc: Font size for the title
    inputBinding:
      position: 101
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - int
    doc: Font size for axis labels
    inputBinding:
      position: 101
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - string
    doc: Comma-separated colors (hex or named)
    inputBinding:
      position: 101
      prefix: --colors
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: Ladderize (sort) the tree before plotting
    inputBinding:
      position: 101
      prefix: --ladderize
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: Draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 101
      prefix: --cladogram
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Draw circular (radial/fan) phylogram instead of rectangular
    inputBinding:
      position: 101
      prefix: --circular
  - id: color_file
    type:
      - 'null'
      - File
    doc: Color annotation file for tip labels, clade ranges, and branch colors
    inputBinding:
      position: 101
      prefix: --color-file
outputs:
  - id: output_plot_output
    type:
      - 'null'
      - File
    doc: output figure path
    outputBinding:
      glob: $(inputs.plot_output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
