cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - scale
label: scanpy-scripts_scanpy-cli_scale
doc: "Scale data per gene.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: no_zero_center
    type:
      - 'null'
      - boolean
    doc: "When set, omit zero-centering variables to allow efficient handling of sparse input."
    inputBinding:
      position: 101
      prefix: --no-zero-center
  - id: max_value
    type:
      - 'null'
      - float
    doc: "When specified, clip to this value after scaling, otherwise do not clip"
    inputBinding:
      position: 101
      prefix: --max-value
  - id: layer
    type:
      - 'null'
      - type: array
        items: string
    doc: "If provided, which element of layers to scale."
    inputBinding:
      position: 101
      prefix: --layer
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
