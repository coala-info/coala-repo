cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - quartet_pie
label: phykit_quartet_pie
doc: Draw a phylogram with pie charts at internal nodes showing quartet 
  concordance proportions.
inputs:
  - id: tree
    type: File
    doc: species tree file
    inputBinding:
      position: 101
      prefix: --tree
  - id: gene_trees
    type:
      - 'null'
      - File
    doc: gene trees file, one Newick tree per line (optional; if omitted, ASTRAL
      -t 2 or wASTRAL --support 3 annotations are parsed)
    inputBinding:
      position: 101
      prefix: --gene-trees
  - id: output
    type: string
    doc: output figure path (supports .png, .pdf, .svg)
    inputBinding:
      position: 101
      prefix: --output
  - id: annotate
    type:
      - 'null'
      - boolean
    doc: show gCF/gDF values as text near each pie chart
    inputBinding:
      position: 101
      prefix: --annotate
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
    doc: font size for tip labels; 0 to hide
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
    doc: comma-separated colors for concordant, disc1, disc2
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
  - id: branch_labels
    type:
      - 'null'
      - boolean
    doc: show concordant gene count above and LPP support below each internal 
      branch (PhyTop-style)
    inputBinding:
      position: 101
      prefix: --branch-labels
  - id: csv
    type: string
    doc: output per-branch concordance values as a CSV file
    inputBinding:
      position: 101
      prefix: --csv
  - id: pie_size
    type:
      - 'null'
      - float
    doc: 'scale factor for pie chart size (default: 1.0; use 2.0 for double, 0.5 for
      half, etc.)'
    inputBinding:
      position: 101
      prefix: --pie-size
  - id: json
    type:
      - 'null'
      - boolean
    doc: optional argument to output per-node concordance as JSON
    inputBinding:
      position: 101
      prefix: --json
outputs:
  - id: output_output
    type: File
    doc: output figure path (supports .png, .pdf, .svg)
    outputBinding:
      glob: $(inputs.output)
  - id: output_csv
    type:
      - 'null'
      - File
    doc: output per-branch concordance values as a CSV file
    outputBinding:
      glob: $(inputs.csv)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
