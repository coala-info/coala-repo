cwlVersion: v1.2
class: CommandLineTool
baseCommand: visualizeclonetree
label: machina_visualizeclonetree
doc: "Visualize a clone tree with optional leaf and vertex labeling, and custom color
  maps.\n\nTool homepage: https://github.com/raphael-group/machina"
inputs:
  - id: clone_tree
    type: File
    doc: Clone tree
    inputBinding:
      position: 1
  - id: leaf_labeling
    type: File
    doc: Leaf labeling
    inputBinding:
      position: 2
  - id: color_map_file
    type:
      - 'null'
      - File
    doc: Color map file
    inputBinding:
      position: 103
      prefix: -c
  - id: vertex_labeling
    type:
      - 'null'
      - File
    doc: Vertex labeling
    inputBinding:
      position: 103
      prefix: -l
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_visualizeclonetree.out
