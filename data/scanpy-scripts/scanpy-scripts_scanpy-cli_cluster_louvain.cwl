cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - cluster
  - louvain
label: scanpy-scripts_scanpy-cli_cluster_louvain
doc: "Find clusters by Louvain algorithm.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: export_cluster_path
    type:
      - 'null'
      - string
    doc: "Export embeddings in a tab-separated text table."
    inputBinding:
      position: 101
      prefix: --export-cluster
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
  - id: directed
    type:
      - 'null'
      - boolean
    doc: "Interpret the adjacency matrix as directed graph. (--directed)"
    inputBinding:
      position: 101
      prefix: --directed
  - id: undirected
    type:
      - 'null'
      - boolean
    doc: "Interpret the adjacency matrix as directed graph. (--undirected)"
    inputBinding:
      position: 101
      prefix: --undirected
  - id: use_weights
    type:
      - 'null'
      - boolean
    doc: "Use weights from KNN graph."
    inputBinding:
      position: 101
      prefix: --use-weights
  - id: restrict_to
    type:
      - 'null'
      - type: array
        items: restrict_to_rec
    doc: "Restrict the clustering to the categories within the key for sample annotation, in the form of \"obs_key list_of_categories\"."
    inputBinding:
      position: 101
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
  - id: flavor
    type:
      - 'null'
      - string
    doc: "Choose between two packages for computing the clustering. \"vtraag\" is much powerful, and the default."
    inputBinding:
      position: 101
      prefix: --flavor
  - id: resolution
    type:
      - 'null'
      - type: array
        items: float
    doc: "For the default flavor \"vtraag\", you can provide a resolution. Higher resolution means finding more and smaller clusters."
    inputBinding:
      position: 101
      prefix: --resolution
      itemSeparator: ','
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
  - id: export_cluster
    type:
      - 'null'
      - File
    doc: "Export embeddings in a tab-separated text table."
    outputBinding:
      glob: $(inputs.export_cluster_path)
requirements:
  - class: InlineJavascriptRequirement
  - class: SchemaDefRequirement
    types:
      - name: restrict_to_rec
        type: record
        fields:
          - name: key
            type: string
            inputBinding:
              position: 1
              prefix: --restrict-to
          - name: categories
            type: string
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
