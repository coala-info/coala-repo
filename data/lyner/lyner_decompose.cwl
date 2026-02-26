cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lyner
  - decompose
label: lyner_decompose
doc: "Decompose a matrix into its constituent parts.\n\nTool homepage: https://github.com/tedil/lyner"
inputs:
  - id: input_matrix
    type: File
    doc: Input matrix file (e.g., CSV, TSV).
    inputBinding:
      position: 1
  - id: center
    type:
      - 'null'
      - boolean
    doc: Center the matrix before decomposition.
    default: false
    inputBinding:
      position: 102
      prefix: --center
  - id: decomposition_method
    type:
      - 'null'
      - string
    doc: Method for decomposition (e.g., 'svd', 'pca', 'nmf').
    default: svd
    inputBinding:
      position: 102
      prefix: --method
  - id: n_components
    type:
      - 'null'
      - int
    doc: Number of components to keep.
    inputBinding:
      position: 102
      prefix: --n-components
  - id: scale
    type:
      - 'null'
      - boolean
    doc: Scale the matrix before decomposition.
    default: false
    inputBinding:
      position: 102
      prefix: --scale
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output.
    default: false
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Directory to save decomposed matrices.
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lyner:0.4.3--py_0
