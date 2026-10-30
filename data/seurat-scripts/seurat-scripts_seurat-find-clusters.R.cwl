cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-find-clusters.R
label: seurat-scripts_seurat-find-clusters.R
doc: 'Cluster the cells of a Seurat object with a shared nearest neighbour graph (Seurat FindClusters).


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
  - id: output_text_file
    type: string
    doc: File name in which to store text format set of clusters.
    inputBinding:
      position: 3
      prefix: --output-text-file=
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
  - id: resolution
    type:
      - 'null'
      - float
    doc: Value of the resolution parameter, use a value above (below) 1.0 if you want to obtain a larger (smaller) number of communities.
    inputBinding:
      position: 6
      prefix: --resolution=
      separate: false
  - id: algorithm
    type:
      - 'null'
      - int
    doc: Algorithm for modularity optimization (1 = original Louvain algorithm; 2 = Louvain algorithm with multilevel refinement; 3 = SLM algorithm; 4 Leiden).
    inputBinding:
      position: 7
      prefix: --algorithm=
      separate: false
  - id: tmp_file_location
    type:
      - 'null'
      - string
    doc: Directory where intermediate files will be written. Specify the ABSOLUTE path.
    inputBinding:
      position: 8
      prefix: --tmp-file-location=
      separate: false
  - id: modularity_fxn
    type:
      - 'null'
      - int
    doc: 'Modularity function: 1 standard, 2 alternative.'
    inputBinding:
      position: 9
      prefix: --modularity-fxn=
      separate: false
  - id: method
    type:
      - 'null'
      - string
    doc: Method for leiden (defaults to matrix which is fast for small datasets). Enable method = \"igraph\" to avoid casting large data to a dense matrix.
    inputBinding:
      position: 10
      prefix: --method=
      separate: false
  - id: graph_name
    type:
      - 'null'
      - string
    doc: Name of graph to use for the clustering algorithm.
    inputBinding:
      position: 11
      prefix: --graph-name=
      separate: false
  - id: nrandom_starts
    type:
      - 'null'
      - int
    doc: Number of random starts
    inputBinding:
      position: 12
      prefix: --nrandom-starts=
      separate: false
  - id: n_iterations
    type:
      - 'null'
      - int
    doc: Maximal number of iterations per random start
    inputBinding:
      position: 13
      prefix: --n-iterations=
      separate: false
  - id: no_group_singletons
    type:
      - 'null'
      - boolean
    doc: Do not group singletons into nearest cluster. If TRUE, assign all singletons to a \"singleton\" group
    inputBinding:
      position: 14
      prefix: --no-group-singletons
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Seed of the random number generator
    inputBinding:
      position: 15
      prefix: --random-seed=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: File name in which to store serialized R object of type 'Seurat'.'
    outputBinding:
      glob: $(inputs.output_object_file)
  - id: output_text_file
    type: File
    doc: File name in which to store text format set of clusters.
    outputBinding:
      glob: $(inputs.output_text_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
