cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - covarying_evolutionary_rates
label: phykit_covarying_evolutionary_rates
doc: Determine if two genes have a signature of covariation with one another by 
  calculating the correlation among relative evolutionary rates between two 
  phylogenies.
inputs:
  - id: tree_file_zero
    type: File
    doc: First argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: tree_file_one
    type:
      - 'null'
      - File
    doc: Second argument after function name should be a tree file
    inputBinding:
      position: 2
  - id: reference
    type:
      - 'null'
      - File
    secondaryFiles:
      - .fai
    doc: A tree to correct branch lengths by in the two input trees. Typically, 
      this is a putative species tree.
    inputBinding:
      position: 103
      prefix: --reference
  - id: plot
    type:
      - 'null'
      - boolean
    doc: optional argument to save a covarying-rates scatter plot
    inputBinding:
      position: 103
      prefix: --plot
  - id: plot_output
    type: string
    doc: output path for plot
    inputBinding:
      position: 103
      prefix: --plot-output
  - id: fig_width
    type:
      - 'null'
      - float
    doc: figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 103
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 103
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution in DPI
    inputBinding:
      position: 103
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: hide the plot title
    inputBinding:
      position: 103
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: custom title text
    inputBinding:
      position: 103
      prefix: --title
  - id: legend_position
    type:
      - 'null'
      - string
    doc: legend location (e.g., "upper right", "none")
    inputBinding:
      position: 103
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for y-axis labels; 0 to hide
    inputBinding:
      position: 103
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for x-axis labels; 0 to hide
    inputBinding:
      position: 103
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - float
    doc: font size for the title
    inputBinding:
      position: 103
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - float
    doc: font size for axis labels
    inputBinding:
      position: 103
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - string
    doc: comma-separated colors (hex or named, e.g., "#ff0000,blue,#00ff00")
    inputBinding:
      position: 103
      prefix: --colors
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: ladderize (sort) the tree before plotting
    inputBinding:
      position: 103
      prefix: --ladderize
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 103
      prefix: --cladogram
  - id: circular
    type:
      - 'null'
      - boolean
    doc: draw circular (radial/fan) phylogram instead of rectangular
    inputBinding:
      position: 103
      prefix: --circular
  - id: color_file
    type:
      - 'null'
      - File
    doc: color annotation file for tip labels, clade ranges, and branch colors 
      (iTOL-inspired TSV format)
    inputBinding:
      position: 103
      prefix: --color-file
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 103
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
