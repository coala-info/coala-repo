cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - phylo_anova
label: phykit_phylo_anova
doc: Phylogenetic ANOVA / MANOVA using the Residual Randomization Permutation 
  Procedure (RRPP). Tests whether a continuous trait (ANOVA) or multiple traits 
  (MANOVA) differ across discrete groups while accounting for phylogenetic 
  non-independence.
inputs:
  - id: tree
    type: File
    doc: species tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: traits
    type:
      - 'null'
      - File
    doc: TSV file with taxon, group column, and one or more response trait 
      columns
    inputBinding:
      position: 101
      prefix: --traits
  - id: group_column
    type:
      - 'null'
      - string
    doc: 'name of the categorical grouping column (default: first non-taxon column)'
    inputBinding:
      position: 101
      prefix: --group-column
  - id: method
    type:
      - 'null'
      - string
    doc: 'analysis method: auto, anova, or manova'
    inputBinding:
      position: 101
      prefix: --method
  - id: permutations
    type:
      - 'null'
      - int
    doc: number of RRPP permutations
    inputBinding:
      position: 101
      prefix: --permutations
  - id: pairwise
    type:
      - 'null'
      - boolean
    doc: include post-hoc pairwise group comparisons
    inputBinding:
      position: 101
      prefix: --pairwise
  - id: plot_output
    type: string
    doc: output figure path (.png, .pdf, .svg)
    inputBinding:
      position: 101
      prefix: --plot-output
  - id: plot_type
    type:
      - 'null'
      - string
    doc: 'boxplot or phylomorphospace (default: auto — boxplot for ANOVA, phylomorphospace
      for MANOVA)'
    inputBinding:
      position: 101
      prefix: --plot-type
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed for reproducible permutations
    inputBinding:
      position: 101
      prefix: --seed
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
    doc: output figure path (.png, .pdf, .svg)
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
