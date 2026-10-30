cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-run-tsne.R
label: seurat-scripts_seurat-run-tsne.R
doc: 'Run t-SNE on a Seurat object (Seurat RunTSNE).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_object_file
    type: string
    doc: File name in which to store serialized R object of type 'Seurat'.'
    inputBinding:
      position: 2
      prefix: --output-object-file=
      separate: false
  - id: output_embeddings_file
    type: string
    doc: File name in which to store a csv-format embeddings table with PCs by cell.
    inputBinding:
      position: 3
      prefix: --output-embeddings-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 4
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 5
      prefix: --output-format=
      separate: false
  - id: reduction_use
    type:
      - 'null'
      - string
    doc: Which dimensional reduction (e.g. PCA, ICA) to use for the tSNE. Default is PCA.
    inputBinding:
      position: 6
      prefix: --reduction-use=
      separate: false
  - id: tsne_method
    type:
      - 'null'
      - string
    doc: 'Select the method to use to compute the tSNE. Available methods are: Rtsne, Flt-SNE'
    inputBinding:
      position: 7
      prefix: --tsne-method=
      separate: false
  - id: perplexity
    type:
      - 'null'
      - int
    doc: Perplexity value for tSNE, if none is set, the default from seurat (30) is used.
    inputBinding:
      position: 8
      prefix: --perplexity=
      separate: false
  - id: cells_use
    type:
      - 'null'
      - File
    doc: File to be used to derive a vector of which cells to analyze (default, all cells).
    inputBinding:
      position: 9
      prefix: --cells-use=
      separate: false
  - id: dim_embed
    type:
      - 'null'
      - int
    doc: The dimensional space of the resulting tSNE embedding (default is 2). For example, set to 3 for a 3d tSNE
    inputBinding:
      position: 10
      prefix: --dim_embed=
      separate: false
  - id: dims_use
    type:
      - 'null'
      - string
    doc: A comma-separated list of the which dimensions to use as input features.
    inputBinding:
      position: 11
      prefix: --dims-use=
      separate: false
  - id: genes_use
    type:
      - 'null'
      - File
    doc: File to be used to derive a vector of gene names. If set, run the tSNE on this subset of genes (instead of running on a set of reduced dimensions). Not set (NULL) by default.
    inputBinding:
      position: 12
      prefix: --genes-use=
      separate: false
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator
    inputBinding:
      position: 13
      prefix: --random-seed=
      separate: false
  - id: add_iter
    type:
      - 'null'
      - boolean
    doc: If an existing tSNE has already been computed, uses the current tSNE to seed the algorithm and then adds additional iterations on top of this
    inputBinding:
      position: 14
      prefix: --add-iter
  - id: reduction_key
    type:
      - 'null'
      - string
    doc: dimensional reduction key, specifies the string before the number for the dimension names. tSNE_ by default
    inputBinding:
      position: 15
      prefix: --reduction-key=
      separate: false
  - id: reduction_name
    type:
      - 'null'
      - string
    doc: dimensional reduction name, specifies the position in the object$dr list. tsne by default
    inputBinding:
      position: 16
      prefix: --reduction-name=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_embeddings_file
    type: File
    doc: File name in which to store a csv-format embeddings table with PCs by cell.
    outputBinding:
      glob: $(inputs.output_embeddings_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
