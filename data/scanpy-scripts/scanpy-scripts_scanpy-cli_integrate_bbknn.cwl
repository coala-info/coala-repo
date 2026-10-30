cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - integrate
  - bbknn
label: scanpy-scripts_scanpy-cli_integrate_bbknn
doc: "Batch balanced kNN [Polanski19].\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: batch_key
    type: string
    doc: "The name of the column in adata.obs that differentiates among experiments/batches."
    inputBinding:
      position: 101
      prefix: --batch-key
  - id: use_rep
    type:
      - 'null'
      - string
    doc: "The dimensionality reduction in .obsm to use for neighbour detection."
    inputBinding:
      position: 101
      prefix: --use-rep
  - id: n_pcs
    type:
      - 'null'
      - int
    doc: "Use this many PCs. Use `.X` if --n-pcs is 0 when --use-rep is None."
    inputBinding:
      position: 101
      prefix: --n-pcs
  - id: no_approx
    type:
      - 'null'
      - boolean
    doc: "Default behaviour is to use annoy’s approximate neighbour finding. This results in a quicker run time for large datasets while also potentially increasing the degree of batch correction. Use this flag to disable that behaviour."
    inputBinding:
      position: 101
      prefix: --no-approx
  - id: metric
    type:
      - 'null'
      - string
    doc: "A known metric’s name."
    inputBinding:
      position: 101
      prefix: --metric
  - id: neighbors_within_batch
    type:
      - 'null'
      - int
    doc: "How many top neighbours to report for each batch; total number of neighbours will be this number times the number of batches."
    inputBinding:
      position: 101
      prefix: --neighbors-within-batch
  - id: trim
    type:
      - 'null'
      - int
    doc: "Trim the neighbours of each cell to these many top connectivities. May help with population independence and improve the tidiness of clustering. The lower the value the more independent the individual populations, at the cost of more conserved batch effect. If None, sets the parameter value automatically to 10 times the total number of neighbours for each cell. Set to 0 to skip."
    inputBinding:
      position: 101
      prefix: --trim
  - id: annoy_n_trees
    type:
      - 'null'
      - int
    doc: "Only used when approx=True. The number of trees to construct in the annoy forest. More trees give higher precision when querying, at the cost of increased run time and resource intensity."
    inputBinding:
      position: 101
      prefix: --annoy-n-trees
  - id: no_use_faiss
    type:
      - 'null'
      - boolean
    doc: "Default behaviour If approx=False and the metric is “euclidean”, is to use the faiss package to compute nearest neighbours if installed. This improves performance at a minor cost to numerical precision as faiss operates on float32. Use this flag to disable that behaviour."
    inputBinding:
      position: 101
      prefix: --no-use-faiss
  - id: set_op_mix_ratio
    type:
      - 'null'
      - float
    doc: "UMAP connectivity computation parameter, float between 0 and 1, controlling the blend between a connectivity matrix formed exclusively from mutual nearest neighbour pairs (0) and a union of all observed neighbour relationships with the mutual pairs emphasised (1)."
    inputBinding:
      position: 101
      prefix: --set-op-mix-ratio
  - id: local_connectivity
    type:
      - 'null'
      - int
    doc: "UMAP connectivity computation parameter, how many nearest neighbors of each cell are assumed to be fully connected (and given a connectivity value of 1)"
    inputBinding:
      position: 101
      prefix: --local-connectivity
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
