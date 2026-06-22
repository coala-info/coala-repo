cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylogenetic_ordination
label: phykit_phylogenetic_ordination
doc: Perform phylogenetic ordination (PCA, t-SNE, or UMAP) on continuous 
  multi-trait data while accounting for phylogenetic non-independence among 
  species.
inputs:
  - id: tree
    type: File
    doc: a tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: trait_data
    type:
      - 'null'
      - File
    doc: tab-delimited multi-trait file with header row
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: method
    type:
      - 'null'
      - string
    doc: 'ordination method: pca, tsne, or umap'
    inputBinding:
      position: 101
      prefix: --method
  - id: correction
    type:
      - 'null'
      - string
    doc: 'phylogenetic correction: BM or lambda'
    inputBinding:
      position: 101
      prefix: --correction
  - id: mode
    type:
      - 'null'
      - string
    doc: 'PCA mode: cov or corr (PCA only)'
    inputBinding:
      position: 101
      prefix: --mode
  - id: n_components
    type:
      - 'null'
      - int
    doc: number of embedding dimensions (tsne/umap only)
    inputBinding:
      position: 101
      prefix: --n-components
  - id: perplexity
    type:
      - 'null'
      - float
    doc: 't-SNE perplexity (default: auto)'
    inputBinding:
      position: 101
      prefix: --perplexity
  - id: n_neighbors
    type:
      - 'null'
      - int
    doc: 'UMAP n_neighbors (default: auto)'
    inputBinding:
      position: 101
      prefix: --n-neighbors
  - id: min_dist
    type:
      - 'null'
      - float
    doc: UMAP min_dist
    inputBinding:
      position: 101
      prefix: --min-dist
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for reproducibility
    inputBinding:
      position: 101
      prefix: --seed
  - id: plot
    type:
      - 'null'
      - boolean
    doc: optional argument to save a scatter plot
    inputBinding:
      position: 101
      prefix: --plot
  - id: plot_tree
    type:
      - 'null'
      - boolean
    doc: overlay phylogeny edges via ancestral reconstruction (default for 
      tsne/umap)
    inputBinding:
      position: 101
      prefix: --plot-tree
  - id: no_plot_tree
    type:
      - 'null'
      - boolean
    doc: disable phylogeny overlay for tsne/umap plots
    inputBinding:
      position: 101
      prefix: --no-plot-tree
  - id: color_by
    type:
      - 'null'
      - string
    doc: color tip points by trait; specify a column name from the multi-trait 
      file or a separate tab-delimited file (taxon<tab>value)
    inputBinding:
      position: 101
      prefix: --color-by
  - id: tree_color_by
    type:
      - 'null'
      - string
    doc: 'color phylogeny edges by a trait; specify a column name or a file (default:
      distance from root)'
    inputBinding:
      position: 101
      prefix: --tree-color-by
  - id: plot_output
    type: string
    doc: output path for plot
    inputBinding:
      position: 101
      prefix: --plot-output
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: optional multi-Newick file of gene trees for discordance-aware VCV 
      computation
    inputBinding:
      position: 101
      prefix: --gene-trees
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
    doc: optional argument to output results as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_plot_output
    type:
      - 'null'
      - File
    doc: output path for plot
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
