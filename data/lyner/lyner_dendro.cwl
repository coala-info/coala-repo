cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - dendro
label: lyner_dendro
doc: "Plot a dendrogram from a distance matrix.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Path to the distance matrix file.
    inputBinding:
      position: 1
  - id: color_threshold
    type:
      - 'null'
      - float
    doc: Color branches below this threshold.
    inputBinding:
      position: 102
      prefix: --color-threshold
  - id: labels
    type:
      - 'null'
      - File
    doc: Optional file containing labels for the dendrogram.
    inputBinding:
      position: 102
      prefix: --labels
  - id: leaf_font_size
    type:
      - 'null'
      - int
    doc: Font size for leaf labels.
    inputBinding:
      position: 102
      prefix: --leaf-font-size
  - id: leaf_rotation
    type:
      - 'null'
      - int
    doc: Rotation angle for leaf labels.
    inputBinding:
      position: 102
      prefix: --leaf-rotation
  - id: linkage
    type:
      - 'null'
      - string
    doc: Type of linkage to use for clustering (e.g., 'single', 'complete', 
      'average', 'weighted').
    inputBinding:
      position: 102
      prefix: --linkage
  - id: no_labels
    type:
      - 'null'
      - boolean
    doc: Do not display labels on the dendrogram.
    inputBinding:
      position: 102
      prefix: --no-labels
  - id: orientation
    type:
      - 'null'
      - string
    doc: Orientation of the dendrogram ('top', 'bottom', 'left', 'right').
    inputBinding:
      position: 102
      prefix: --orientation
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Path to save the dendrogram image.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
