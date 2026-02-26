cwlVersion: v1.2
class: CommandLineTool
baseCommand: phylip_drawtree
label: phylip_drawtree
doc: "Draws trees in various formats.\n\nTool homepage: http://evolution.genetics.washington.edu/phylip/"
inputs:
  - id: input_tree_file
    type: File
    doc: Input tree file
    inputBinding:
      position: 1
  - id: color
    type:
      - 'null'
      - string
    doc: Color for labels
    inputBinding:
      position: 102
  - id: flip
    type:
      - 'null'
      - string
    doc: Flip the tree along the specified axis
    inputBinding:
      position: 102
  - id: font
    type:
      - 'null'
      - string
    doc: Font to use for labels
    inputBinding:
      position: 102
  - id: format
    type:
      - 'null'
      - string
    doc: Format of the output tree (e.g., 'newick', 'nexus', 'phylip')
    inputBinding:
      position: 102
  - id: height
    type:
      - 'null'
      - int
    doc: Height of the drawing
    inputBinding:
      position: 102
  - id: labels
    type:
      - 'null'
      - string
    doc: Label the nodes with their names
    inputBinding:
      position: 102
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: Do not label the nodes
    inputBinding:
      position: 102
  - id: no_root
    type:
      - 'null'
      - boolean
    doc: Do not root the tree
    inputBinding:
      position: 102
  - id: root
    type:
      - 'null'
      - string
    doc: Root the tree at the specified node
    inputBinding:
      position: 102
  - id: rotate
    type:
      - 'null'
      - float
    doc: Rotate the tree by the specified angle
    inputBinding:
      position: 102
  - id: scale
    type:
      - 'null'
      - boolean
    doc: Scale the tree branches by their lengths
    inputBinding:
      position: 102
  - id: size
    type:
      - 'null'
      - int
    doc: Font size for labels
    inputBinding:
      position: 102
  - id: unscaled
    type:
      - 'null'
      - boolean
    doc: Do not scale the tree branches
    inputBinding:
      position: 102
  - id: width
    type:
      - 'null'
      - int
    doc: Line width for drawing
    inputBinding:
      position: 102
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file for the drawing
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylip:3.697--h470a237_0
