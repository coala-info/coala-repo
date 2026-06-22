cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - chronogram
label: phykit_chronogram
doc: Plot a chronogram (time-calibrated phylogeny) with geological timescale 
  bands. Requires an ultrametric tree and the root age in millions of years 
  (Ma).
inputs:
  - id: tree
    type: File
    doc: ultrametric tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: root_age
    type: float
    doc: age of the root in Ma
    inputBinding:
      position: 101
      prefix: --root-age
  - id: plot_output
    type: string
    doc: output figure path (.png, .pdf, .svg)
    inputBinding:
      position: 101
      prefix: --plot-output
  - id: timescale
    type:
      - 'null'
      - string
    doc: 'timescale level: auto, epoch, period, or era. Auto selects based on root
      age.'
    inputBinding:
      position: 101
      prefix: --timescale
  - id: node_ages
    type:
      - 'null'
      - boolean
    doc: label internal nodes with divergence times (Ma)
    inputBinding:
      position: 101
      prefix: --node-ages
  - id: circular
    type:
      - 'null'
      - boolean
    doc: draw circular chronogram
    inputBinding:
      position: 101
      prefix: --circular
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: ladderize the tree
    inputBinding:
      position: 101
      prefix: --ladderize
  - id: color_file
    type:
      - 'null'
      - File
    doc: color annotation file (iTOL-inspired TSV)
    inputBinding:
      position: 101
      prefix: --color-file
  - id: json
    type:
      - 'null'
      - boolean
    doc: output node ages as JSON
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
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: Draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 101
      prefix: --cladogram
outputs:
  - id: output_plot_output
    type: File
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
