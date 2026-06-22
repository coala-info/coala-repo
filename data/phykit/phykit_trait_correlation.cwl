cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - trait_correlation
label: phykit_trait_correlation
doc: Compute phylogenetic correlations between all pairs of traits and display 
  them as a heatmap with significance indicators. Uses GLS-centering via the 
  tree's variance-covariance matrix to account for phylogenetic 
  non-independence.
inputs:
  - id: tree
    type: File
    doc: tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: multi-trait TSV with header row
    inputBinding:
      position: 101
      prefix: --trait-data
  - id: output
    type: string
    doc: output figure path (supports .png, .pdf, .svg)
    inputBinding:
      position: 101
      prefix: --output
  - id: alpha
    type:
      - 'null'
      - float
    doc: significance threshold for marking p-values
    inputBinding:
      position: 101
      prefix: --alpha
  - id: cluster
    type:
      - 'null'
      - boolean
    doc: cluster traits by correlation similarity and display dendrograms
    inputBinding:
      position: 101
      prefix: --cluster
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: optional multi-Newick file of gene trees for discordance-aware VCV 
      computation
    inputBinding:
      position: 101
      prefix: --gene-trees
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
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
  - id: output_output
    type: File
    doc: output figure path (supports .png, .pdf, .svg)
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
