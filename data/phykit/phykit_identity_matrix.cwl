cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - identity_matrix
label: phykit_identity_matrix
doc: Compute a pairwise sequence identity matrix from an alignment and plot it 
  as a clustered heatmap.
inputs:
  - id: alignment
    type: File
    doc: alignment file (FASTA or other supported format)
    inputBinding:
      position: 101
      prefix: --alignment
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
    doc: "'identity' (fraction matching) or 'p-distance' (1 - identity)"
    inputBinding:
      position: 101
      prefix: --metric
  - id: tree
    type:
      - 'null'
      - File
    doc: tree file for tree-guided ordering (Newick format)
    inputBinding:
      position: 101
      prefix: --tree
  - id: sort
    type:
      - 'null'
      - string
    doc: "ordering method: 'cluster' (hierarchical), 'tree' (requires --tree), or
      'alpha' (alphabetical)"
    inputBinding:
      position: 101
      prefix: --sort
  - id: partition
    type:
      - 'null'
      - File
    doc: RAxML-style partition file (reserved for future use)
    inputBinding:
      position: 101
      prefix: --partition
  - id: json
    type:
      - 'null'
      - boolean
    doc: output structured JSON instead of plain text
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phykit:2.1.92--pyhdfd78af_0
s:url: https://github.com/jlsteenwyk/phykit
$namespaces:
  s: https://schema.org/
