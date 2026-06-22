cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - ancestral_state_reconstruction
label: phykit_ancestral_state_reconstruction
doc: Estimate ancestral states using maximum likelihood. Supports continuous 
  (Brownian Motion) and discrete (Mk) models.
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
    doc: trait data file (2-column or multi-trait with header)
    inputBinding:
      position: 101
      prefix: --trait_data
  - id: trait
    type:
      - 'null'
      - string
    doc: trait column name (required for multi-trait files)
    inputBinding:
      position: 101
      prefix: --trait
  - id: type
    type:
      - 'null'
      - string
    doc: 'trait type: continuous or discrete'
    inputBinding:
      position: 101
      prefix: --type
  - id: method
    type:
      - 'null'
      - string
    doc: 'method to use: fast or ml (continuous only)'
    inputBinding:
      position: 101
      prefix: --method
  - id: model
    type:
      - 'null'
      - string
    doc: 'Mk model: ER, SYM, or ARD (discrete only)'
    inputBinding:
      position: 101
      prefix: --model
  - id: ci
    type:
      - 'null'
      - boolean
    doc: include 95% confidence intervals (continuous only)
    inputBinding:
      position: 101
      prefix: --ci
  - id: plot
    type: string
    doc: output path for plot
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
  - id: plot_ci
    type:
      - 'null'
      - boolean
    doc: draw confidence interval bars at internal nodes on the contMap plot 
      (requires --ci and --plot)
    inputBinding:
      position: 101
      prefix: --plot-ci
  - id: ci_size
    type:
      - 'null'
      - float
    doc: 'scale factor for CI bar size (default: 1.0; use 2.0 for larger, 0.5 for
      smaller)'
    inputBinding:
      position: 101
      prefix: --ci-size
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
      - File
    doc: output path for plot
    outputBinding:
      glob: $(inputs.plot)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
