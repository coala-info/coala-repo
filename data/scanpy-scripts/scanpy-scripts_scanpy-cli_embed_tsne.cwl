cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - embed
  - tsne
label: scanpy-scripts_scanpy-cli_embed_tsne
doc: "Embed the cells using t-SNE.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: n_pcs
    type:
      - 'null'
      - int
    doc: "Use this many PCs. Use `.X` if --n-pcs is 0 when --use-rep is None."
    inputBinding:
      position: 101
      prefix: --n-pcs
  - id: use_rep
    type:
      - 'null'
      - string
    doc: "Use the indicated representation. If None, the representation is chosen automatically: for `.n_vars` < 50, `.X` is used, otherwise `X_pca` is used. If `X_pca` is not present, it's computed with default parameters."
    inputBinding:
      position: 101
      prefix: --use-rep
  - id: random_state
    type:
      - 'null'
      - int
    doc: "Seed for random number generator."
    inputBinding:
      position: 101
      prefix: --random-state
  - id: key_added
    type:
      - 'null'
      - type: array
        items: string
    doc: "Key under which to add the computed results"
    inputBinding:
      position: 101
      prefix: --key-added
      itemSeparator: ','
  - id: n_jobs
    type:
      - 'null'
      - int
    doc: "Number of jobs for parallel computation."
    inputBinding:
      position: 101
      prefix: --n-jobs
  - id: export_embedding_path
    type:
      - 'null'
      - string
    doc: "Export embeddings in a tab-separated text table."
    inputBinding:
      position: 101
      prefix: --export-embedding
  - id: perplexity
    type:
      - 'null'
      - float
    doc: "The perplexity is related to the number of nearest neighbors that is used in other manifold learning algorithms. Larger datasets usually require a larger perplexity. Consider selecting a value between 5 and 50. The choice is not extremely critical since t-SNE is quite insensitive to this parameter."
    inputBinding:
      position: 101
      prefix: --perplexity
  - id: early_exaggeration
    type:
      - 'null'
      - float
    doc: "Controls how tight natural clusters in the original space are in the embedded space and how much space will be between them. For larger values, the space between natural clusters will be larger in the embedded space. Again, the choice of this parameter is not very critical. If the cost function increases during initial optimization, the early exaggeration factor or the learning rate might be too high."
    inputBinding:
      position: 101
      prefix: --early-exaggeration
  - id: learning_rate
    type:
      - 'null'
      - float
    doc: "Note that the R-package \"Rtsne\" uses a default of 200. The learning rate can be a critical parameter. It should be between 100 and 1000. If the cost function increases during initial optimization, the early exaggeration factor or the learning rate might be too high. If the cost function gets stuck in a bad local minimum increasing the learning rate helps sometimes."
    inputBinding:
      position: 101
      prefix: --learning-rate
  - id: no_fast_tsne
    type:
      - 'null'
      - boolean
    doc: "When NOT set, use the MulticoreTSNE package by D. Ulyanov if installed."
    inputBinding:
      position: 101
      prefix: --no-fast-tsne
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
