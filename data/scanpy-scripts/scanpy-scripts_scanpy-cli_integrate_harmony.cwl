cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - integrate
  - harmony
label: scanpy-scripts_scanpy-cli_integrate_harmony
doc: "Use harmonypy [Korunsky19] to integrate different experiments.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs:
  - id: input_obj
    type: File
    doc: input file in format specified by --input-format
    inputBinding:
      position: 1
  - id: output_obj_path
    type: string
    doc: output file in format specified by --output-format
    inputBinding:
      position: 2
  - id: input_format
    type:
      - 'null'
      - string
    doc: "Input object format."
    inputBinding:
      position: 101
      prefix: --input-format
  - id: output_format
    type:
      - 'null'
      - string
    doc: "Output object format."
    inputBinding:
      position: 101
      prefix: --output-format
  - id: zarr_chunk_size
    type:
      - 'null'
      - int
    doc: "Chunk size for writing output in zarr format."
    inputBinding:
      position: 101
      prefix: --zarr-chunk-size
  - id: loom_write_obsm_varm
    type:
      - 'null'
      - boolean
    doc: "Write obsm and varm to the Loom file?"
    inputBinding:
      position: 101
      prefix: --loom-write-obsm-varm
  - id: export_mtx_path
    type:
      - 'null'
      - string
    doc: "When specified, using it as prefix for exporting mtx files. If not empty and not ending with \"/\" or \"_\", a \"_\" will be appended."
    inputBinding:
      position: 101
      prefix: --export-mtx
  - id: mtx_compression
    type:
      - 'null'
      - string
    doc: "Compression type for MTX output."
    inputBinding:
      position: 101
      prefix: --mtx-compression
  - id: show_obj
    type:
      - 'null'
      - string
    doc: "Print output object summary info to specified stream."
    inputBinding:
      position: 101
      prefix: --show-obj
  - id: batch_key
    type: string
    doc: "The name of the column in adata.obs that differentiates among experiments/batches."
    inputBinding:
      position: 101
      prefix: --batch-key
  - id: basis
    type:
      - 'null'
      - string
    doc: "The name of the field in adata.obsm where the PCA table is stored. Defaults to 'X_pca', which is the default for sc.tl.pca()."
    inputBinding:
      position: 101
      prefix: --basis
  - id: adjusted_basis
    type:
      - 'null'
      - string
    doc: "The name of the field in adata.obsm where the adjusted PCA table will be stored after running this function."
    inputBinding:
      position: 101
      prefix: --adjusted-basis
  - id: theta
    type:
      - 'null'
      - float
    doc: "Diversity clustering penalty parameter. theta=0 does not encourage any diversity. Larger values of theta result in more diverse clusters."
    inputBinding:
      position: 101
      prefix: --theta
  - id: lambda
    type:
      - 'null'
      - float
    doc: "Ridge regression penalty parameter. Lambda must be strictly positive. Smaller values result in more aggressive correction."
    inputBinding:
      position: 101
      prefix: --lambda
  - id: sigma
    type:
      - 'null'
      - float
    doc: "Width of soft kmeans clusters. Sigma scales the distance from a cell to cluster centroids. Larger values of sigma result in cells assigned to more clusters. Smaller values of sigma make soft kmeans cluster approach hard clustering."
    inputBinding:
      position: 101
      prefix: --sigma
  - id: n_clust
    type:
      - 'null'
      - int
    doc: "Number of clusters in model. nclust=1 equivalent to simple linear regression."
    inputBinding:
      position: 101
      prefix: --n-clust
  - id: tau
    type:
      - 'null'
      - int
    doc: "Protection against overclustering small datasets with large ones. tau is the expected number of cells per cluster."
    inputBinding:
      position: 101
      prefix: --tau
  - id: block_size
    type:
      - 'null'
      - float
    doc: "What proportion of cells to update during clustering. Between 0 to 1, default 0.05. Larger values may be faster but less accurate."
    inputBinding:
      position: 101
      prefix: --block-size
  - id: max_iter_cluster
    type:
      - 'null'
      - int
    doc: "Maximum number of rounds to run clustering at each round of Harmony."
    inputBinding:
      position: 101
      prefix: --max-iter-cluster
  - id: max_iter_harmony
    type:
      - 'null'
      - int
    doc: "Maximum number of rounds to run Harmony. One round of Harmony involves one clustering and one correction step."
    inputBinding:
      position: 101
      prefix: --max-iter-harmony
  - id: epsilon_cluster
    type:
      - 'null'
      - float
    doc: "Convergence tolerance for clustering round of Harmony Set to -Inf to never stop early."
    inputBinding:
      position: 101
      prefix: --epsilon-cluster
  - id: epsilon_harmony
    type:
      - 'null'
      - float
    doc: "Convergence tolerance for clustering round of Harmony Set to -Inf to never stop early."
    inputBinding:
      position: 101
      prefix: --epsilon-harmony
  - id: random_state
    type:
      - 'null'
      - int
    doc: "Seed for random number generator."
    inputBinding:
      position: 101
      prefix: --random-state
outputs:
  - id: output_obj
    type:
      - File
      - Directory
    doc: output object (a directory for the zarr format)
    outputBinding:
      glob: $(inputs.output_obj_path)
  - id: export_mtx
    type:
      type: array
      items: File
    doc: "When specified, using it as prefix for exporting mtx files. If not empty and not ending with \"/\" or \"_\", a \"_\" will be appended. (files written with the given prefix)"
    outputBinding:
      glob: $(inputs.export_mtx_path)*
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
