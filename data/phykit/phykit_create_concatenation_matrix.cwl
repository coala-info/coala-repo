cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - phykit
  - create_concatenation_matrix
label: phykit_create_concatenation_matrix
doc: 'Create a concatenated alignment file. This function is used to help in the construction
  of multi-locus data matrices. PhyKIT will output three files: a fasta file, a partition
  file, and an occupancy file.'
inputs:
  - id: alignment
    type: File
    doc: alignment list file. File should contain a single column list of 
      alignment sequence files to concatenate into a single matrix.
    inputBinding:
      position: 101
      prefix: --alignment
  - id: prefix
    type: string
    doc: prefix of output files
    inputBinding:
      position: 101
      prefix: --prefix
  - id: threshold
    type:
      - 'null'
      - float
    doc: minimum fraction of informative (non-gap, non-ambiguous) sites across 
      the concatenated alignment for a taxon to be included. Set to 0 to disable
      filtering.
    inputBinding:
      position: 101
      prefix: --threshold
  - id: plot_occupancy
    type:
      - 'null'
      - boolean
    doc: optional argument to generate occupancy map figure
    inputBinding:
      position: 101
      prefix: --plot-occupancy
  - id: plot_output
    type: string
    doc: 'output path for occupancy figure (supports .png, .pdf, .svg, .jpg). default:
      <prefix>.occupancy.png'
    inputBinding:
      position: 101
      prefix: --plot-output
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
  - id: output_prefix
    type: File[]
    doc: prefix of output files
    outputBinding:
      glob: $(inputs.prefix)*
  - id: output_plot_output
    type:
      - 'null'
      - File
    doc: 'output path for occupancy figure (supports .png, .pdf, .svg, .jpg). default:
      <prefix>.occupancy.png'
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
