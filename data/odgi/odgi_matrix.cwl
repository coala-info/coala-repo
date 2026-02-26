cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi_matrix
label: odgi_matrix
doc: "Write the graph topology in sparse matrix format.\n\nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: delta_weight
    type:
      - 'null'
      - boolean
    doc: Weigh edges by the inverse id delta.
    inputBinding:
      position: 101
      prefix: --delta-weight
  - id: edge_depth_weight
    type:
      - 'null'
      - boolean
    doc: Weigh edges by their path depth.
    inputBinding:
      position: 101
      prefix: --edge-depth-weight
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
stdout: odgi_matrix.out
