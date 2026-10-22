cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - embed
  - umap
label: scanpy-scripts_scanpy-cli_embed_umap
doc: "Embed the neighborhood graph using UMAP.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: neighbors_key
    type:
      - 'null'
      - string
    doc: "If not specified, look in .uns[‘neighbors’] for neighbors settings and .obsp[‘connectivities’], .obsp[‘distances’] for connectivities and distances respectively (default storage places for pp.neighbors). If specified, look in .uns[neighbors_key] for neighbors settings and .obsp[.uns[neighbors_key][‘connectivitie s_key’]], .obsp[.uns[neighbors_key][‘distances_key’]] for connectivities and distances respectively."
    inputBinding:
      position: 101
      prefix: --neighbors-key
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
  - id: export_embedding_path
    type:
      - 'null'
      - string
    doc: "Export embeddings in a tab-separated text table."
    inputBinding:
      position: 101
      prefix: --export-embedding
  - id: init_pos
    type:
      - 'null'
      - string
    doc: "How to initialize the low dimensional embedding. Can be \"spectral\", \"paga\" or \"random\", or any key of `.obsm`."
    inputBinding:
      position: 101
      prefix: --init-pos
  - id: min_dist
    type:
      - 'null'
      - float
    doc: "The effective minimum distance between embedded points. Smaller values will result in a more clustered embedding, while larger values will results in a more even dispersal of points."
    inputBinding:
      position: 101
      prefix: --min-dist
  - id: spread
    type:
      - 'null'
      - float
    doc: "The effective scale of embedded points, which determines the scale at which embedded points will be spread out."
    inputBinding:
      position: 101
      prefix: --spread
  - id: n_components
    type:
      - 'null'
      - int
    doc: "The number of dimensions of the embedding."
    inputBinding:
      position: 101
      prefix: --n-components
  - id: maxiter
    type:
      - 'null'
      - int
    doc: "The number of iterations of the optimization."
    inputBinding:
      position: 101
      prefix: --maxiter
  - id: alpha
    type:
      - 'null'
      - float
    doc: "The initial learning rate for the embedding optimization."
    inputBinding:
      position: 101
      prefix: --alpha
  - id: gamma
    type:
      - 'null'
      - float
    doc: "Weighting applied to negative samples in low dimensional embedding optimization."
    inputBinding:
      position: 101
      prefix: --gamma
  - id: negative_sample_rate
    type:
      - 'null'
      - int
    doc: "The number of negative edge samples to use per positive edge sample in optimizing the low dimensional embedding."
    inputBinding:
      position: 101
      prefix: --negative-sample-rate
  - id: method
    type:
      - 'null'
      - string
    doc: "Use the original ‘umap’ implementation, or ‘rapids’ (experimental, GPU only)."
    inputBinding:
      position: 101
      prefix: --method
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
