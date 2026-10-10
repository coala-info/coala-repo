cwlVersion: v1.2
class: CommandLineTool
baseCommand: plot_tree_graphlan.py
label: metaphlan_plot_tree_graphlan
doc: "Plot a tree with GraPhlAn, optionally colouring the leaves by a metadata field.\n\nTool homepage: https://github.com/biobakery/metaphlan"
requirements:
  - class: InlineJavascriptRequirement
inputs:
  - id: ifn_tree
    type: File
    doc: "The input tree in newick format."
    inputBinding:
      position: 101
      prefix: "--ifn_tree"
  - id: colorized_metadata
    type:
      - 'null'
      - string
    doc: "The metadata field to colorize. Default \"unset\"."
    inputBinding:
      position: 101
      prefix: "--colorized_metadata"
  - id: fig_size
    type:
      - 'null'
      - float
    doc: "The figure size. Default \"8\"."
    inputBinding:
      position: 101
      prefix: "--fig_size"
  - id: legend_marker_size
    type:
      - 'null'
      - int
    doc: "The legend marker size. Default \"20\"."
    inputBinding:
      position: 101
      prefix: "--legend_marker_size"
  - id: legend_font_size
    type:
      - 'null'
      - int
    doc: "The legend font size. Default \"10\"."
    inputBinding:
      position: 101
      prefix: "--legend_font_size"
  - id: legend_marker_edge_width
    type:
      - 'null'
      - float
    doc: "The legend marker edge width. Default \"0.2\"."
    inputBinding:
      position: 101
      prefix: "--legend_marker_edge_width"
  - id: leaf_marker_size
    type:
      - 'null'
      - int
    doc: "The legend marker size. Default \"20\"."
    inputBinding:
      position: 101
      prefix: "--leaf_marker_size"
  - id: leaf_marker_edge_width
    type:
      - 'null'
      - float
    doc: "The legend marker edge width. Default \"0.2\"."
    inputBinding:
      position: 101
      prefix: "--leaf_marker_edge_width"
  - id: dpi
    type:
      - 'null'
      - int
    doc: "The figure dpi."
    inputBinding:
      position: 101
      prefix: "--dpi"
  - id: figure_extension
    type:
      - 'null'
      - string
    doc: "The figure extension. Default \".png\"."
    inputBinding:
      position: 101
      prefix: "--figure_extension"
  - id: ofn_prefix
    type: string
    doc: "The prefix of output files."
    default: "tree_plot"
    inputBinding:
      position: 101
      prefix: "--ofn_prefix"
outputs:
  - id: figure
    type:
      type: array
      items: File
    doc: "The figure and the GraPhlAn annotation files"
    outputBinding:
      glob: "$(inputs.ofn_prefix)*"
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/metaphlan:4.2.4--pyhdfd78af_0
stdout: metaphlan_plot_tree_graphlan.out
