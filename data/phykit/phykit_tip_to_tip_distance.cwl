cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - tip_to_tip_distance
label: phykit_tip_to_tip_distance
doc: Calculate distance between two tips (or leaves) in a phylogeny. Distances 
  are in substitutions per site.
inputs:
  - id: tree_file
    type: File
    doc: First argument after function name should be a tree file
    inputBinding:
      position: 1
  - id: tip_1
    type:
      - 'null'
      - string
    doc: Second argument after function name should be one of the tip names
    inputBinding:
      position: 2
  - id: tip_2
    type:
      - 'null'
      - string
    doc: Third argument after function name should be the second tip name
    inputBinding:
      position: 3
  - id: all_pairs
    type:
      - 'null'
      - boolean
    doc: optional argument to report all pairwise tip distances
    inputBinding:
      position: 104
      prefix: --all-pairs
  - id: plot
    type:
      - 'null'
      - boolean
    doc: optional argument to save a clustered distance heatmap (requires 
      --all-pairs)
    inputBinding:
      position: 104
      prefix: --plot
  - id: plot_output
    type: string
    doc: output path for heatmap
    inputBinding:
      position: 104
      prefix: --plot-output
  - id: fig_width
    type:
      - 'null'
      - float
    doc: figure width in inches (auto-scaled if omitted)
    inputBinding:
      position: 104
      prefix: --fig-width
  - id: fig_height
    type:
      - 'null'
      - float
    doc: figure height in inches (auto-scaled if omitted)
    inputBinding:
      position: 104
      prefix: --fig-height
  - id: dpi
    type:
      - 'null'
      - int
    doc: resolution in DPI
    inputBinding:
      position: 104
      prefix: --dpi
  - id: no_title
    type:
      - 'null'
      - boolean
    doc: hide the plot title
    inputBinding:
      position: 104
      prefix: --no-title
  - id: title
    type:
      - 'null'
      - string
    doc: custom title text
    inputBinding:
      position: 104
      prefix: --title
  - id: legend_position
    type:
      - 'null'
      - string
    doc: legend location (e.g., 'upper right', 'none')
    inputBinding:
      position: 104
      prefix: --legend-position
  - id: ylabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for y-axis labels; 0 to hide
    inputBinding:
      position: 104
      prefix: --ylabel-fontsize
  - id: xlabel_fontsize
    type:
      - 'null'
      - float
    doc: font size for x-axis labels; 0 to hide
    inputBinding:
      position: 104
      prefix: --xlabel-fontsize
  - id: title_fontsize
    type:
      - 'null'
      - float
    doc: font size for the title
    inputBinding:
      position: 104
      prefix: --title-fontsize
  - id: axis_fontsize
    type:
      - 'null'
      - float
    doc: font size for axis labels
    inputBinding:
      position: 104
      prefix: --axis-fontsize
  - id: colors
    type:
      - 'null'
      - string
    doc: comma-separated colors (hex or named, e.g., '#ff0000,blue,#00ff00')
    inputBinding:
      position: 104
      prefix: --colors
  - id: ladderize
    type:
      - 'null'
      - boolean
    doc: ladderize (sort) the tree before plotting
    inputBinding:
      position: 104
      prefix: --ladderize
  - id: cladogram
    type:
      - 'null'
      - boolean
    doc: draw cladogram (equal branch lengths, tips aligned) instead of 
      phylogram
    inputBinding:
      position: 104
      prefix: --cladogram
  - id: circular
    type:
      - 'null'
      - boolean
    doc: draw circular (radial/fan) phylogram instead of rectangular
    inputBinding:
      position: 104
      prefix: --circular
  - id: color_file
    type:
      - 'null'
      - File
    doc: color annotation file for tip labels, clade ranges, and branch colors 
      (iTOL-inspired TSV format)
    inputBinding:
      position: 104
      prefix: --color-file
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output results as JSON
    inputBinding:
      position: 104
      prefix: --json
outputs:
  - id: output_plot_output
    type:
      - 'null'
      - File
    doc: output path for heatmap
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
