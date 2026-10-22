cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - neighbor
label: scanpy-scripts_scanpy-cli_neighbor
doc: "Compute a neighbourhood graph of observations.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: random_state
    type:
      - 'null'
      - int
    doc: "Seed for random number generator."
    inputBinding:
      position: 101
      prefix: --random-state
  - id: n_neighbors
    type:
      - 'null'
      - type: array
        items: string
    doc: "The size of local neighborhood (in terms of number of neighboring data points) used for manifold approximation. Larger values result in more global views of the manifold, while smaller values result in more local data being preserved. In general values should be in the range 2 to 100. If --knn is set, number of nearest neighbors to be searched, othwise a Gaussian kernel width is set to the distance of the --n-neighbors neighbor."
    inputBinding:
      position: 101
      prefix: --n-neighbors
      itemSeparator: ','
  - id: no_knn
    type:
      - 'null'
      - boolean
    doc: "When NOT set, use a hard threshold to restrict the number of neighbors to --n-neighbors. Otherwise, use a Gaussian kernel to assign low weights to neighbors more distant than the --n-neighbors nearest neighbor"
    inputBinding:
      position: 101
      prefix: --no-knn
  - id: method
    type:
      - 'null'
      - string
    doc: "Use umap or gauss with adaptive width for computing connectivities. Use rapids for the RAPIDS implementation of UMAP (experimental, GPU only)."
    inputBinding:
      position: 101
      prefix: --method
  - id: metric
    type:
      - 'null'
      - string
    doc: "A known metric’s name."
    inputBinding:
      position: 101
      prefix: --metric
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
