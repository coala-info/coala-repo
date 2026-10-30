cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - integrate
  - mnn
label: scanpy-scripts_scanpy-cli_integrate_mnn
doc: "Correct batch effects by matching mutual nearest neighbors [Haghverdi18] [Kang18].\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: save_raw
    type:
      - 'null'
      - boolean
    doc: "Save adata to adata.raw before processing."
    inputBinding:
      position: 101
      prefix: --save-raw
  - id: save_layer
    type:
      - 'null'
      - string
    doc: "Save adata.X to the specified layer before processing."
    inputBinding:
      position: 101
      prefix: --save-layer
  - id: batch_key
    type: string
    doc: "The name of the column in adata.obs that differentiates among experiments/batches."
    inputBinding:
      position: 101
      prefix: --batch-key
  - id: layer
    type:
      - 'null'
      - string
    doc: "Layer to batch correct. By default corrects the contents of .X."
    inputBinding:
      position: 101
      prefix: --layer
  - id: key_added
    type:
      - 'null'
      - string
    doc: "Key under which to add the computed results. By default a new layer will be created called 'mnn', 'mnn_{layer}' or 'mnn_layer_{key_added}' where those parameters were specified. A value of 'X' causes batch-corrected values to overwrite the original content of .X."
    inputBinding:
      position: 101
      prefix: --key-added
  - id: var_subset
    type:
      - 'null'
      - type: array
        items: var_subset_rec
    doc: "The subset of vars (list of str) to be used when performing MNN correction in the format of '--var-subset <name> <values>'. Typically, use the highly variable genes (HVGs) like '--var-subset highly_variable True'. When unset, uses all vars."
    inputBinding:
      position: 101
  - id: n_neighbors
    type:
      - 'null'
      - type: array
        items: int
    doc: "Number of mutual nearest neighbors."
    inputBinding:
      position: 101
      prefix: --n-neighbors
      itemSeparator: ','
  - id: sigma
    type:
      - 'null'
      - float
    doc: "The bandwidth of the Gaussian smoothing kernel used to compute the correction vectors."
    inputBinding:
      position: 101
      prefix: --sigma
  - id: no_cos_norm_in
    type:
      - 'null'
      - boolean
    doc: "Default behaviour is to perform cosine normalization on the input data prior to calculating distances between cells. Use this flag to disable that behaviour."
    inputBinding:
      position: 101
      prefix: --no-cos_norm_in
  - id: no_cos_norm_out
    type:
      - 'null'
      - boolean
    doc: "Default behaviour is to perform cosine normalization prior to computing corrected expression values. Use this flag to disable that behaviour."
    inputBinding:
      position: 101
      prefix: --no-cos_norm_out
  - id: svd_dim
    type:
      - 'null'
      - int
    doc: "The number of dimensions to use for summarizing biological substructure within each batch. If not set, biological components will not be removed from the correction vectors."
    inputBinding:
      position: 101
      prefix: --svd-dim
  - id: no_var_adj
    type:
      - 'null'
      - boolean
    doc: "Default behaviour is to adjust variance of the correction vectors. Use this flag to disable that behaviour. Note this step takes most computing time."
    inputBinding:
      position: 101
      prefix: --no-var-adj
  - id: compute_angle
    type:
      - 'null'
      - boolean
    doc: "When set, compute the angle between each cell’s correction vector and the biological subspace of the reference batch."
    inputBinding:
      position: 101
      prefix: --compute-angle
  - id: svd_mode
    type:
      - 'null'
      - string
    doc: "'svd' computes SVD using a non-randomized SVD-via-ID algorithm, while 'rsvd' uses a randomized version. 'irlb' performs truncated SVD by implicitly restarted Lanczos bidiagonalization (forked from https://github.com/airysen/irlbpy)."
    inputBinding:
      position: 101
      prefix: --svd-mode
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
  - class: SchemaDefRequirement
    types:
      - name: var_subset_rec
        type: record
        fields:
          - name: key
            type: string
            inputBinding:
              position: 1
              prefix: --var-subset
          - name: categories
            type: string
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
