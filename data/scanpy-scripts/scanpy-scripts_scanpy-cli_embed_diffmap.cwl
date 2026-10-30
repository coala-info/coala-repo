cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - embed
  - diffmap
label: scanpy-scripts_scanpy-cli_embed_diffmap
doc: "Embed the neighborhood graph using diffusion map.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: n_comps
    type:
      - 'null'
      - int
    doc: "Number of components to compute (scanpy's own default is 15)"
    inputBinding:
      position: 101
      prefix: --n-comps
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
