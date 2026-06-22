cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - spectral_discordance
label: phykit_spectral_discordance
doc: Spectral discordance decomposition — decompose gene tree space via PCA on a
  bipartition presence/absence (or branch-length) matrix, with spectral 
  clustering and automatic cluster detection via the eigengap heuristic.
inputs:
  - id: gene_trees
    type: File
    doc: file of gene trees (one Newick per line, or file of filenames)
    inputBinding:
      position: 101
      prefix: --gene-trees
  - id: tree
    type:
      - 'null'
      - File
    doc: species tree (optional; flags species-tree bipartitions in loading 
      output)
    inputBinding:
      position: 101
      prefix: --tree
  - id: metric
    type:
      - 'null'
      - string
    doc: 'distance metric: nrf or wrf'
    inputBinding:
      position: 101
      prefix: --metric
  - id: clusters
    type:
      - 'null'
      - int
    doc: override auto-detected K
    inputBinding:
      position: 101
      prefix: --clusters
  - id: n_pcs
    type:
      - 'null'
      - int
    doc: 'number of PCs to report (default: min(10, G-1))'
    inputBinding:
      position: 101
      prefix: --n-pcs
  - id: top_loadings
    type:
      - 'null'
      - int
    doc: top bipartitions per PC
    inputBinding:
      position: 101
      prefix: --top-loadings
  - id: plot
    type:
      - 'null'
      - string
    doc: output prefix for plots (generates _scatter.png and _eigengap.png)
    inputBinding:
      position: 101
      prefix: --plot
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
    doc: resolution in DPI
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
  - id: legend_position
    type:
      - 'null'
      - string
    doc: legend location (e.g., "upper right", "none")
    inputBinding:
      position: 101
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for y-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for x-axis labels; 0 to hide
    inputBinding:
      position: 101
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - float
    doc: font size for the title
    inputBinding:
      position: 101
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - float
    doc: font size for axis labels
    inputBinding:
      position: 101
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - string
    doc: comma-separated colors (hex or named, e.g., "#ff0000,blue,#00ff00")
    inputBinding:
      position: 101
      prefix: --colors
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: ladderize (sort) the tree before plotting
    inputBinding:
      position: 101
      prefix: --ladderize
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 101
      prefix: --cladogram
  - id: circular
    type:
      - 'null'
      - boolean
    doc: draw circular (radial/fan) phylogram instead of rectangular
    inputBinding:
      position: 101
      prefix: --circular
  - id: color_file
    type:
      - 'null'
      - File
    doc: color annotation file for tip labels, clade ranges, and branch colors 
      (iTOL-inspired TSV format)
    inputBinding:
      position: 101
      prefix: --color-file
  - id: json
    type:
      - 'null'
      - boolean
    doc: output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_plot
    type:
      - 'null'
      - File[]
    doc: output prefix for plots (generates _scatter.png and _eigengap.png)
    outputBinding:
      glob: $(inputs.plot)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
