cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_tension
label: odgi_tension
doc: "evaluate the tension of a graph helping to locate structural variants and abnormalities\n\
  \nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: coords_in
    type: File
    doc: read the layout coordinates from this .lay format file produced by odgi
      sort or odgi layout
    inputBinding:
      position: 101
      prefix: --coords-in
  - id: idx
    type: File
    doc: load the graph from this file
    inputBinding:
      position: 101
      prefix: --idx
  - id: node_sized_windows
    type:
      - 'null'
      - boolean
    doc: instead of manual window sizes, each window has the size of the node of
      the step we are currently iterating
    inputBinding:
      position: 101
      prefix: --node-sized-windows
  - id: pangenome_mode
    type:
      - 'null'
      - boolean
    doc: 'calculate the tension for each node of the pangenome: node tension is the
      sum of the tension of all steps visiting that node. Results are written in TSV
      format to stdout. 1st col: node identifier. 2nd col: tension=(path_layout_dist/path_nuc_dist).
      3rd col: 2nd_col/#steps_on_node.'
    inputBinding:
      position: 101
      prefix: --pangenome-mode
  - id: progress
    type:
      - 'null'
      - boolean
    doc: display progress
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads to use for parallel phases
    inputBinding:
      position: 101
      prefix: --threads
  - id: window_size
    type:
      - 'null'
      - int
    doc: window size in bases in which each tension is calculated
    inputBinding:
      position: 101
      prefix: --window-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_tension.out
