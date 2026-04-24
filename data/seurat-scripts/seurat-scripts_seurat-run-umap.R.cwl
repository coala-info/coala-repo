cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-run-umap.R
label: seurat-scripts_seurat-run-umap.R
doc: "Run UMAP (Uniform Manifold Approximation and Projection) on a Seurat object.
  Note: The provided input text was a container build error log; arguments below are
  derived from standard seurat-scripts documentation for this tool.\n\nTool homepage:
  https://github.com/ebi-gene-expression-group/r-seurat-scripts"
inputs:
  - id: dims
    type:
      - 'null'
      - string
    doc: Dimensions of reduction to use as input. A comma-separated list of integers.
    inputBinding:
      position: 101
      prefix: --dims
  - id: input_object_file
    type: File
    doc: File name in which a serialized Seurat object can be found.
    inputBinding:
      position: 101
      prefix: --input-object-file
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: The initial learning rate used for SGD.
    inputBinding:
      position: 101
      prefix: --learning-rate
  - id: metric
    type:
      - 'null'
      - string
    doc: Metric to use for distance computation.
    inputBinding:
      position: 101
      prefix: --metric
  - id: min_dist
    type:
      - 'null'
      - float
    doc: The effective minimum distance between embedded points.
    inputBinding:
      position: 101
      prefix: --min-dist
  - id: n_components
    type:
      - 'null'
      - int
    doc: The dimension of the space to embed into.
    inputBinding:
      position: 101
      prefix: --n-components
  - id: n_epochs
    type:
      - 'null'
      - int
    doc: The number of training epochs to be used in optimizing the low-dimensional
      embedding.
    inputBinding:
      position: 101
      prefix: --n-epochs
  - id: n_neighbors
    type:
      - 'null'
      - int
    doc: This determines the number of neighboring points used in local approximations
      of manifold structure.
    inputBinding:
      position: 101
      prefix: --n-neighbors
  - id: reduction
    type:
      - 'null'
      - string
    doc: Which dimensional reduction to use.
    inputBinding:
      position: 101
      prefix: --reduction
  - id: spread
    type:
      - 'null'
      - float
    doc: The effective scale of embedded points.
    inputBinding:
      position: 101
      prefix: --spread
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store the serialized Seurat object.
    outputBinding:
      glob: $(inputs.output_object_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
