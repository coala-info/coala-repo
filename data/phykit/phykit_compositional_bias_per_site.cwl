cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - compositional_bias_per_site
label: phykit_compositional_bias_per_site
doc: Calculates compositional bias per site in an alignment using site-wise 
  chi-squared tests.
inputs:
  - id: alignment
    type: File
    doc: First argument after the function name should be a fasta alignment file
    inputBinding:
      position: 1
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Optional argument to save a Manhattan-style plot of compositional bias 
      per site
    inputBinding:
      position: 102
      prefix: --plot
  - id: plot_output
    type: string
    doc: Output path for plot
    inputBinding:
      position: 102
      prefix: --plot-output
  - id: fig_width
    type:
      - 'null'
      - float
    doc: Figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 102
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: Figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 102
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: Resolution in DPI
    inputBinding:
      position: 102
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: Hide the plot title
    inputBinding:
      position: 102
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: Custom title text
    inputBinding:
      position: 102
      prefix: --title
  - id: legend_position
    type:
      - 'null'
      - string
    doc: Legend location (e.g., 'upper right', 'none')
    inputBinding:
      position: 102
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - float
    doc: Font size for y-axis labels; 0 to hide
    inputBinding:
      position: 102
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - float
    doc: Font size for x-axis labels; 0 to hide
    inputBinding:
      position: 102
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - float
    doc: Font size for the title
    inputBinding:
      position: 102
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - float
    doc: Font size for axis labels
    inputBinding:
      position: 102
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - string
    doc: Comma-separated colors (hex or named, e.g., '#ff0000,blue,#00ff00')
    inputBinding:
      position: 102
      prefix: --colors
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: Ladderize (sort) the tree before plotting
    inputBinding:
      position: 102
      prefix: --ladderize
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: Draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 102
      prefix: --cladogram
  - id: circular
    type:
      - 'null'
      - boolean
    doc: Draw circular (radial/fan) phylogram instead of rectangular
    inputBinding:
      position: 102
      prefix: --circular
  - id: color_file
    type:
      - 'null'
      - File
    doc: Color annotation file for tip labels, clade ranges, and branch colors 
      (iTOL-inspired TSV format)
    inputBinding:
      position: 102
      prefix: --color-file
  - id: json
    type:
      - 'null'
      - boolean
    doc: Optional argument to output results as JSON
    inputBinding:
      position: 102
      prefix: --json
outputs:
  - id: output_plot_output
    type:
      - 'null'
      - File
    doc: Output path for plot
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
