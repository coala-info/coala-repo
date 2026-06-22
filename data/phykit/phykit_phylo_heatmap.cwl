cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylo_heatmap
label: phykit_phylo_heatmap
doc: 'Draw a phylogenetic heatmap: a phylogeny alongside a color-coded matrix of numeric
  trait values. Rows are aligned to tree tips.'
inputs:
  - id: tree
    type: File
    doc: tree file (required)
    inputBinding:
      position: 101
      prefix: --tree
  - id: data
    type:
      - 'null'
      - File
    doc: numeric data matrix in TSV format with header row (required)
    inputBinding:
      position: 101
      prefix: --data
  - id: output
    type: string
    doc: output figure path (required; supports .png, .pdf, .svg)
    inputBinding:
      position: 101
      prefix: --output
  - id: split
    type:
      - 'null'
      - float
    doc: 'fraction of figure width for the tree panel (default: 0.3)'
    inputBinding:
      position: 101
      prefix: --split
  - id: standardize
    type:
      - 'null'
      - boolean
    doc: z-score each column before coloring
    inputBinding:
      position: 101
      prefix: --standardize
  - id: cmap
    type:
      - 'null'
      - string
    doc: 'matplotlib colormap name (default: viridis)'
    inputBinding:
      position: 101
      prefix: --cmap
  - id: cluster_columns
    type:
      - 'null'
      - boolean
    doc: cluster trait columns by similarity and display a dendrogram at the top
    inputBinding:
      position: 101
      prefix: --cluster-columns
  - id: fig_width
    type:
      - 'null'
      - float
    doc: figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 101
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: 'resolution in DPI (default: 300)'
    inputBinding:
      position: 101
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: hide the plot title
    inputBinding:
      position: 101
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: custom title text
    inputBinding:
      position: 101
      prefix: --title
  - id: ylabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for taxon labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for trait column labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --xlabel-fontsize
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output metadata as JSON
    inputBinding:
      position: 101
      prefix: --json
  - id: legend_position
    type:
      - 'null'
      - string
    doc: Legend location (e.g., 'upper right', 'none' to hide)
    inputBinding:
      position: 101
      prefix: --legend-position
  - id: title_fontsize
    type:
      - 'null'
      - float
    doc: Font size for the title
    inputBinding:
      position: 101
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - float
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
  - id: output_output
    type: File
    doc: output figure path (required; supports .png, .pdf, .svg)
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
