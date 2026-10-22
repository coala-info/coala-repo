cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - norm
label: scanpy-scripts_scanpy-cli_norm
doc: "Normalise data per cell.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: no_log_transform
    type:
      - 'null'
      - boolean
    doc: "When set, do not apply (natural) log transform following normalisation."
    inputBinding:
      position: 101
      prefix: --no-log-transform
  - id: normalize_to
    type:
      - 'null'
      - float
    doc: "Normalize per cell nUMI to this number."
    inputBinding:
      position: 101
      prefix: --normalize-to
  - id: exclude_highly_expressed
    type:
      - 'null'
      - boolean
    doc: "Exclude (very) highly expressed genes for the computation of the normalization factor (size factor) for each cell. A gene is considered highly expressed, if it has more than max_fraction of the total counts in at least one cell. The not-excluded genes will sum up to the number specified by --normalize-to."
    inputBinding:
      position: 101
      prefix: --exclude-highly-expressed
  - id: max_fraction
    type:
      - 'null'
      - float
    doc: "If exclude_highly_expressed=True, consider cells as highly expressed that have more counts than max_fraction of the original total counts in at least one cell."
    inputBinding:
      position: 101
      prefix: --max-fraction
  - id: layers
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of layers to normalize. Set to 'all' to normalize all layers."
    inputBinding:
      position: 101
      prefix: --layers
      itemSeparator: ','
  - id: layer_norm
    type:
      - 'null'
      - string
    doc: "Specifies how to normalize layers: 1) If None, after normalization, for each layer in layers each cell has a total count equal to the median of the counts_per_cell before normalization of the layer. 2) If 'after', for each layer in layers each cell has a total count equal to target_sum. 3) If 'X', for each layer in layers each cell has a total count equal to the median of total counts for observations (cells) of adata.X before normalization.'"
    inputBinding:
      position: 101
      prefix: --layer-norm
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
