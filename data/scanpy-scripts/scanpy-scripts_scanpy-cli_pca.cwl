cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - pca
label: scanpy-scripts_scanpy-cli_pca
doc: "Dimensionality reduction by PCA.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: no_zero_center
    type:
      - 'null'
      - boolean
    doc: "When set, omit zero-centering variables to allow efficient handling of sparse input."
    inputBinding:
      position: 101
      prefix: --no-zero-center
  - id: random_state
    type:
      - 'null'
      - int
    doc: "Seed for random number generator."
    inputBinding:
      position: 101
      prefix: --random-state
  - id: export_embedding_path
    type:
      - 'null'
      - string
    doc: "Export embeddings in a tab-separated text table."
    inputBinding:
      position: 101
      prefix: --export-embedding
  - id: n_comps
    type:
      - 'null'
      - int
    doc: "Number of components to compute"
    inputBinding:
      position: 101
      prefix: --n-comps
  - id: svd_solver
    type:
      - 'null'
      - string
    doc: "SVD solver to use."
    inputBinding:
      position: 101
      prefix: --svd-solver
  - id: use_all
    type:
      - 'null'
      - boolean
    doc: "When set, use all genes for PCA, otherwise use highly-variable genes by default."
    inputBinding:
      position: 101
      prefix: --use-all
  - id: chunked
    type:
      - 'null'
      - boolean
    doc: "When set, perform an incremental PCA on segments of --chunk-size, which automatically zero centers and ignore settings of --random-state and --svd-solver."
    inputBinding:
      position: 101
      prefix: --chunked
  - id: chunk_size
    type:
      - 'null'
      - int
    doc: "Number of observations to include in each chunk, required by --chunked."
    inputBinding:
      position: 101
      prefix: --chunk-size
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
  - id: export_embedding
    type:
      - 'null'
      - File
    doc: "Export embeddings in a tab-separated text table."
    outputBinding:
      glob: $(inputs.export_embedding_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
