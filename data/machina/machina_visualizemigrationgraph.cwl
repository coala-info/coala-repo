cwlVersion: v1.2
class: CommandLineTool
baseCommand: visualizemigrationgraph
label: machina_visualizemigrationgraph
doc: "Visualize the migration graph of a clone tree.\n\nTool homepage: https://github.com/raphael-group/machina"
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
  - id: vertex_labeling
    type: string
    doc: Vertex labeling
    inputBinding:
      position: 3
  - id: color_map_file
    type:
      - 'null'
      - string
    doc: Color map file
    inputBinding:
      position: 104
      prefix: --color-map-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/machina:1.2--h21ec9f0_7
stdout: machina_visualizemigrationgraph.out
