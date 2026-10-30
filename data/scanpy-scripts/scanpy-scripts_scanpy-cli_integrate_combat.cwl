cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - integrate
  - combat
label: scanpy-scripts_scanpy-cli_integrate_combat
doc: "ComBat function for batch effect correction\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
    doc: "Key under which to add the computed results. By default a new layer will be created called 'combat', 'combat_{layer}' or 'combat_layer_{key_added}' where those parameters were specified. A value of 'X' causes batch-corrected values to overwrite the original content of .X."
    inputBinding:
      position: 101
      prefix: --key-added
  - id: covariates
    type:
      - 'null'
      - type: array
        items: string
    doc: "Comma-separated list of additional covariates besides the batch variable such as adjustment variables or biological condition. This parameter refers to the design matrix X in Equation 2.1 in [Johnson07] and to the mod argument in the original combat function in the sva R package. Note that not including covariates may introduce bias or lead to the removal of biological signal in unbalanced designs."
    inputBinding:
      position: 101
      prefix: --covariates
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
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
