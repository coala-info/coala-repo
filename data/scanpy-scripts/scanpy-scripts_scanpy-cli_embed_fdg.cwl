cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - embed
  - fdg
label: scanpy-scripts_scanpy-cli_embed_fdg
doc: "Embed the neighborhood graph using force-directed graph.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: root
    type:
      - 'null'
      - int
    doc: "If choosing a tree layout, this is the index of the root node."
    inputBinding:
      position: 101
      prefix: --root
  - id: init_pos
    type:
      - 'null'
      - string
    doc: "Use precomputed coordinates for initialization. Can be any key of `.obsm` or \"paga\" if .uns[\"paga\"] is present"
    inputBinding:
      position: 101
      prefix: --init-pos
  - id: layout
    type:
      - 'null'
      - string
    doc: "Name of any valid igraph layout, including \"fa\" (ForceAtlas2), \"fr\" (Fruchterman Reingold), \"grid_fr\" (Grid Fruchterman Reingold, faster than \"fr\"), \"kk\" (Kamadi Kawai, slower than \"fr\"), \"lgl\" (Large Graph Layout, very fast), \"drl\" (Distributed Recursive Layout, pretty fast) and \"rt\" (Reingold Tilford tree layout)."
    inputBinding:
      position: 101
      prefix: --layout
  - id: key_added_ext
    type:
      - 'null'
      - string
    doc: "By default, append 'layout'"
    inputBinding:
      position: 101
      prefix: --key-added-ext
  - id: neighbors_key
    type:
      - 'null'
      - string
    doc: "If not specified, look in .uns[‘neighbors’] for neighbors settings and .obsp[‘connectivities’], .obsp[‘distances’] for connectivities and distances respectively (default storage places for pp.neighbors). If specified, look in .uns[neighbors_key] for neighbors settings and .obsp[.uns[neighbors_key][‘connectivitie s_key’]], .obsp[.uns[neighbors_key][‘distances_key’]] for connectivities and distances respectively."
    inputBinding:
      position: 101
      prefix: --neighbors-key
  - id: obsp
    type:
      - 'null'
      - string
    doc: "Use .obsp[obsp] as adjacency. You can’t specify both obsp and neighbors_key at the same time."
    inputBinding:
      position: 101
      prefix: --obsp
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
