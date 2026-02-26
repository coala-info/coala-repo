cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylovega
label: phylovega
doc: "Visualize phylogenetic trees with customizable styling.\n\nTool homepage: https://github.com/Zsailer/phylovega"
inputs:
  - id: branch_color
    type:
      - 'null'
      - string
    doc: Set the color of the tree branches.
    inputBinding:
      position: 101
      prefix: --branch_color
  - id: branch_width
    type:
      - 'null'
      - string
    doc: Set the width of the tree branches.
    inputBinding:
      position: 101
      prefix: --branch_width
  - id: data
    type:
      - 'null'
      - string
    doc: Specify the data source for the tree.
    inputBinding:
      position: 101
      prefix: --data
  - id: height
    type:
      - 'null'
      - string
    doc: Set the height of the tree visualization.
    inputBinding:
      position: 101
      prefix: --height
  - id: height_scale
    type:
      - 'null'
      - string
    doc: Set the scale for the height of the tree.
    inputBinding:
      position: 101
      prefix: --height_scale
  - id: leaf_color
    type:
      - 'null'
      - string
    doc: Set the color of the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_color
  - id: leaf_edge_color
    type:
      - 'null'
      - string
    doc: Set the edge color of the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_edge_color
  - id: leaf_edge_width
    type:
      - 'null'
      - string
    doc: Set the edge width of the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_edge_width
  - id: leaf_labels
    type:
      - 'null'
      - string
    doc: Specify labels for the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_labels
  - id: leaf_size
    type:
      - 'null'
      - string
    doc: Set the size of the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_size
  - id: leaf_text_color
    type:
      - 'null'
      - string
    doc: Set the text color for the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_text_color
  - id: leaf_text_column
    type:
      - 'null'
      - string
    doc: Specify a column for leaf text.
    inputBinding:
      position: 101
      prefix: --leaf_text_column
  - id: leaf_text_size
    type:
      - 'null'
      - string
    doc: Set the text size for the tree leaves.
    inputBinding:
      position: 101
      prefix: --leaf_text_size
  - id: leaf_text_xoffset
    type:
      - 'null'
      - string
    doc: Set the x-offset for leaf text.
    inputBinding:
      position: 101
      prefix: --leaf_text_xoffset
  - id: leaf_text_yoffset
    type:
      - 'null'
      - string
    doc: Set the y-offset for leaf text.
    inputBinding:
      position: 101
      prefix: --leaf_text_yoffset
  - id: node_color
    type:
      - 'null'
      - string
    doc: Set the color of the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_color
  - id: node_edge_color
    type:
      - 'null'
      - string
    doc: Set the edge color of the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_edge_color
  - id: node_edge_width
    type:
      - 'null'
      - string
    doc: Set the edge width of the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_edge_width
  - id: node_labels
    type:
      - 'null'
      - string
    doc: Specify labels for the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_labels
  - id: node_size
    type:
      - 'null'
      - string
    doc: Set the size of the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_size
  - id: node_text_color
    type:
      - 'null'
      - string
    doc: Set the text color for the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_text_color
  - id: node_text_column
    type:
      - 'null'
      - string
    doc: Specify a column for node text.
    inputBinding:
      position: 101
      prefix: --node_text_column
  - id: node_text_size
    type:
      - 'null'
      - string
    doc: Set the text size for the tree nodes.
    inputBinding:
      position: 101
      prefix: --node_text_size
  - id: node_text_xoffset
    type:
      - 'null'
      - string
    doc: Set the x-offset for node text.
    inputBinding:
      position: 101
      prefix: --node_text_xoffset
  - id: node_text_yoffset
    type:
      - 'null'
      - string
    doc: Set the y-offset for node text.
    inputBinding:
      position: 101
      prefix: --node_text_yoffset
  - id: padding
    type:
      - 'null'
      - string
    doc: Set the padding around the tree visualization.
    inputBinding:
      position: 101
      prefix: --padding
  - id: width
    type:
      - 'null'
      - string
    doc: Set the width of the tree visualization.
    inputBinding:
      position: 101
      prefix: --width
  - id: width_scale
    type:
      - 'null'
      - string
    doc: Set the scale for the width of the tree.
    inputBinding:
      position: 101
      prefix: --width_scale
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylovega:0.3--py_0
stdout: phylovega.out
