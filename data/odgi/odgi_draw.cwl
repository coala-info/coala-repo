cwlVersion: v1.2
class: CommandLineTool
baseCommand: odgi draw
label: odgi_draw
doc: "Draw previously-determined 2D layouts of the graph with diverse annotations.\n\
  \nTool homepage: https://github.com/vgteam/odgi"
inputs:
  - id: bed_file
    type:
      - 'null'
      - File
    doc: Color the nodes based on the input annotation in the given BED FILE. 
      Colors are derived from the 4th column, if present, else from the path 
      name.If the 4th column value is in the format 'string#RRGGBB', the RRGGBB 
      color (in hex notation) will be used.
    inputBinding:
      position: 101
      prefix: --bed-file
  - id: border
    type:
      - 'null'
      - float
    doc: Image border (in approximate bp)
    inputBinding:
      position: 101
      prefix: --border
  - id: color_paths
    type:
      - 'null'
      - boolean
    doc: Color paths (in PNG output).
    inputBinding:
      position: 101
      prefix: --color-paths
  - id: coords_in
    type: File
    doc: Read the layout coordinates from this .lay format FILE produced by odgi
      layout.
    inputBinding:
      position: 101
      prefix: --coords-in
  - id: idx
    type: File
    doc: Load the succinct variation graph in ODGI format from this *FILE*. The 
      file name usually ends with *.og*. It also accepts GFAv1, but the 
      on-the-fly conversion to the ODGI format requires additional time!
    inputBinding:
      position: 101
      prefix: --idx
  - id: line_width
    type:
      - 'null'
      - float
    doc: Line width (in approximate bp)
    inputBinding:
      position: 101
      prefix: --line-width
  - id: path_index
    type:
      - 'null'
      - File
    doc: Load the path index from this FILE.
    inputBinding:
      position: 101
      prefix: --path-index
  - id: path_line_spacing
    type:
      - 'null'
      - float
    doc: Spacing between path lines in PNG layout (in approximate bp)
    inputBinding:
      position: 101
      prefix: --path-line-spacing
  - id: png_border
    type:
      - 'null'
      - int
    doc: Size of PNG border in bp
    inputBinding:
      position: 101
      prefix: --png-border
  - id: png_height
    type:
      - 'null'
      - int
    doc: Height of PNG rendering
    inputBinding:
      position: 101
      prefix: --png-height
  - id: progress
    type:
      - 'null'
      - boolean
    doc: Write the current progress to stderr.
    inputBinding:
      position: 101
      prefix: --progress
  - id: scale
    type:
      - 'null'
      - float
    doc: SVG image scaling
    inputBinding:
      position: 101
      prefix: --scale
  - id: svg_lengthen_nodes
    type:
      - 'null'
      - boolean
    doc: When node sparsitication is active, lengthen the remaining nodes 
      proportionally with the sparsification factor
    inputBinding:
      position: 101
      prefix: --svg-lengthen-nodes
  - id: svg_sparse_factor
    type:
      - 'null'
      - float
    doc: Remove this fraction of nodes from the SVG output (to output smaller 
      files)
    inputBinding:
      position: 101
      prefix: --svg-sparse-factor
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for parallel operations.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: tsv
    type:
      - 'null'
      - File
    doc: Write the TSV layout plus displayed annotations to this FILE.
    outputBinding:
      glob: $(inputs.tsv)
  - id: svg
    type:
      - 'null'
      - File
    doc: Write an SVG rendering to this FILE.
    outputBinding:
      glob: $(inputs.svg)
  - id: png
    type:
      - 'null'
      - File
    doc: Write a rasterized PNG rendering to this FILE.
    outputBinding:
      glob: $(inputs.png)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odgi:0.9.4--h077b44d_0
