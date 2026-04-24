cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_graphdr
label: quasildr_run_graphdr.py
doc: "Run GraphDR.\n\nTool homepage: https://github.com/jzthree/quasildr"
inputs:
  - id: input_file
    type: File
    doc: Input data file
    inputBinding:
      position: 1
  - id: anno_column
    type:
      - 'null'
      - string
    doc: Name of the column to use in annotation file
    inputBinding:
      position: 102
      prefix: --anno_column
  - id: anno_file
    type:
      - 'null'
      - File
    doc: Annotation of categories used for plotting or use with `--lda`.
    inputBinding:
      position: 102
      prefix: --anno_file
  - id: lda
    type:
      - 'null'
      - boolean
    doc: Preprocess input with LDA (using `anno_column` in `anno_file` as 
      labels)
    inputBinding:
      position: 102
      prefix: --lda
  - id: log
    type:
      - 'null'
      - boolean
    doc: Preprocess input with log(1+X) transform.
    inputBinding:
      position: 102
      prefix: --log
  - id: max_dim
    type:
      - 'null'
      - int
    doc: Number of input dims to use
    inputBinding:
      position: 102
      prefix: --max_dim
  - id: method
    type:
      - 'null'
      - string
    doc: Method
    inputBinding:
      position: 102
      prefix: --method
  - id: metric
    type:
      - 'null'
      - string
    doc: Metric
    inputBinding:
      position: 102
      prefix: --metric
  - id: n_neighbors
    type:
      - 'null'
      - int
    doc: Number of neighbors to construct KNN graph
    inputBinding:
      position: 102
      prefix: --n_neighbors
  - id: no_rotation
    type:
      - 'null'
      - boolean
    doc: Run GraphDR with --no_rotation option.
    inputBinding:
      position: 102
      prefix: --no_rotation
  - id: output
    type:
      - 'null'
      - string
    doc: Output file prefix, use input_file if not specified
    inputBinding:
      position: 102
      prefix: --output
  - id: pca
    type:
      - 'null'
      - boolean
    doc: Preprocess input with PCA.
    inputBinding:
      position: 102
      prefix: --pca
  - id: plot
    type:
      - 'null'
      - boolean
    doc: Generate a pdf plot of the first two dims of the representation.
    inputBinding:
      position: 102
      prefix: --plot
  - id: refine_iter
    type:
      - 'null'
      - int
    doc: Refine iteration
    inputBinding:
      position: 102
      prefix: --refine_iter
  - id: refine_threshold
    type:
      - 'null'
      - int
    doc: Refine threshold
    inputBinding:
      position: 102
      prefix: --refine_threshold
  - id: reg
    type:
      - 'null'
      - int
    doc: Regularization parameter
    inputBinding:
      position: 102
      prefix: --reg
  - id: rescale
    type:
      - 'null'
      - boolean
    doc: Postprocess output by rescaling to match input mean and variance.
    inputBinding:
      position: 102
      prefix: --rescale
  - id: scale
    type:
      - 'null'
      - boolean
    doc: Preprocess input by scaling to unit variance.
    inputBinding:
      position: 102
      prefix: --scale
  - id: suffix
    type:
      - 'null'
      - string
    doc: Suffix append to output file name
    inputBinding:
      position: 102
      prefix: --suffix
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Preprocess input by transposing the matrix.
    inputBinding:
      position: 102
      prefix: --transpose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/quasildr:0.2.2--pyhdfd78af_0
stdout: quasildr_run_graphdr.py.out
