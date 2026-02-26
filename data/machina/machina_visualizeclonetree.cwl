cwlVersion: v1.2
class: CommandLineTool
baseCommand: visualizeclonetree
label: machina_visualizeclonetree
doc: "Visualize a clone tree with optional leaf and vertex labeling, and custom color
  maps.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: clone_tree
    type: string
    doc: Clone tree
    inputBinding:
      position: 1
  - id: leaf_labeling
    type: string
    doc: Leaf labeling
    inputBinding:
      position: 2
  - id: color_map_file
    type:
      - 'null'
      - string
    doc: Color map file
    inputBinding:
      position: 103
      prefix: --color_map_file
  - id: vertex_labeling
    type:
      - 'null'
      - string
    doc: Vertex labeling
    inputBinding:
      position: 103
      prefix: --vertex_labeling
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_visualizeclonetree.out
