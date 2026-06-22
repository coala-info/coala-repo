cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - tree_space
label: phykit_tree_space
doc: Tree space visualization — visualize how gene trees cluster in topology 
  space using MDS, t-SNE, or UMAP on pairwise tree distance matrices.
inputs:
  - id: trees
    type: File
    doc: file with gene trees (one Newick per line, or one path per line)
    inputBinding:
      position: 101
      prefix: --trees
  - id: output
    type: string
    doc: output figure path (.png, .pdf, .svg)
    inputBinding:
      position: 101
      prefix: --output
  - id: metric
    type:
      - 'null'
      - string
    doc: 'distance metric: rf (Robinson-Foulds, default) or kf (Kuhner-Felsenstein)'
    inputBinding:
      position: 101
      prefix: --metric
  - id: method
    type:
      - 'null'
      - string
    doc: 'dimensionality reduction: mds (default), tsne, or umap'
    inputBinding:
      position: 101
      prefix: --method
  - id: species_tree
    type:
      - 'null'
      - File
    doc: optional species tree to highlight in the plot
    inputBinding:
      position: 101
      prefix: --species-tree
  - id: k
    type:
      - 'null'
      - int
    doc: number of clusters (auto-detected via eigengap if omitted)
    inputBinding:
      position: 101
      prefix: --k
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for reproducibility (t-SNE/UMAP)
    inputBinding:
      position: 101
      prefix: --seed
  - id: heatmap
    type:
      - 'null'
      - boolean
    doc: draw a clustered distance heatmap instead of a scatter plot
    inputBinding:
      position: 101
      prefix: --heatmap
  - id: distance_matrix
    type: string
    doc: output pairwise distance matrix as CSV file
    inputBinding:
      position: 101
      prefix: --distance-matrix
  - id: json
    type:
      - 'null'
      - boolean
    doc: output structured JSON
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
    doc: 'Resolution in DPI (default: 300)'
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
      - float
    doc: Font size for y-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - float
    doc: Font size for x-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --xlabel-fontsize
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
    doc: output figure path (.png, .pdf, .svg)
    outputBinding:
      glob: $(inputs.output)
  - id: output_distance_matrix
    type:
      - 'null'
      - File
    doc: output pairwise distance matrix as CSV file
    outputBinding:
      glob: $(inputs.distance_matrix)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
