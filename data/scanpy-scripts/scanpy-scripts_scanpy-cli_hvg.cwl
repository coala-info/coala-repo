cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - hvg
label: scanpy-scripts_scanpy-cli_hvg
doc: "Find highly variable genes.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: mean_limits
    type:
      - 'null'
      - type: array
        items: float
    doc: "Cutoffs for the mean of expressionin the format of \"-m min max\"."
    inputBinding:
      position: 101
      prefix: --mean-limits
  - id: disp_limits
    type:
      - 'null'
      - type: array
        items: float
    doc: "Cutoffs for the dispersion of expressionin the format of \"-d min max\"."
    inputBinding:
      position: 101
      prefix: --disp-limits
  - id: span
    type:
      - 'null'
      - float
    doc: "The fraction of the data (cells) used when estimating the variance in the loess model fit if flavor='seurat_v3'."
    inputBinding:
      position: 101
      prefix: --span
  - id: n_bins
    type:
      - 'null'
      - int
    doc: "Number of bins for binning the mean gene expression."
    inputBinding:
      position: 101
      prefix: --n-bins
  - id: n_top_genes
    type:
      - 'null'
      - int
    doc: "Number of highly-variable genes to keep."
    inputBinding:
      position: 101
      prefix: --n-top-genes
  - id: flavor
    type:
      - 'null'
      - string
    doc: "Choose the flavor for computing normalized dispersion."
    inputBinding:
      position: 101
      prefix: --flavor
  - id: subset
    type:
      - 'null'
      - boolean
    doc: "When set, inplace subset to highly-variable genes, otherwise only flag highly-variable genes."
    inputBinding:
      position: 101
      prefix: --subset
  - id: batch_key
    type:
      - 'null'
      - string
    doc: "If specified, highly-variable genes are selected within each batch separately and merged. This simple process avoids the selection of batch-specific genes and acts as a lightweight batch correction method. For all flavors, genes are first sorted by how many batches they are a HVG. For dispersion-based flavors ties are broken by normalized dispersion. If flavor = 'seurat_v3', ties are broken by the median (across batches) rank based on within-batch normalized variance."
    inputBinding:
      position: 101
      prefix: --batch-key
  - id: always_hv_genes_file
    type:
      - 'null'
      - File
    doc: "If specified, the gene identifers in this file will be set as highly variable in the var dataframe after HVGs are computed."
    inputBinding:
      position: 101
      prefix: --always-hv-genes-file
  - id: never_hv_genes_file
    type:
      - 'null'
      - File
    doc: "If specified, the gene identifers in this file will be removed from highly variable in the var dataframe (set to false) after HVGs are computed."
    inputBinding:
      position: 101
      prefix: --never-hv-genes-file
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
