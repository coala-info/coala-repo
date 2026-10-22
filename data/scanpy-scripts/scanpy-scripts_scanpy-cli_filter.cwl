cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - filter
label: scanpy-scripts_scanpy-cli_filter
doc: "Filter data based on specified conditions.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: gene_name
    type:
      - 'null'
      - string
    doc: "Name of the variable that contains gene names, used for flagging mitochondria genes when column \"mito\" is absent from `.var`."
    inputBinding:
      position: 101
      prefix: --gene-name
  - id: list_attr
    type:
      - 'null'
      - boolean
    doc: "When set, list attributes that can be filtered on."
    inputBinding:
      position: 101
      prefix: --list-attr
  - id: param
    type:
      - 'null'
      - type: array
        items: filter_param_rec
    doc: "Numerical parameters used to filter the data, in the format of \"-p name min max\". Multiple -p entries allowed."
    inputBinding:
      position: 101
  - id: category
    type:
      - 'null'
      - type: array
        items: filter_category_rec
    doc: "Categorical attributes used to filter the data, in the format of \"-c <name> <values>\", where entries with attribute <name> with value in <values> are kept. If <values> is preceded by \"!\", entries with value in <values> are removed. Multiple -c entries allowed."
    inputBinding:
      position: 101
  - id: subset
    type:
      - 'null'
      - type: array
        items: filter_subset_rec
    doc: "Similar to --category in the format of \"-s <name> <file>\", but the <file> to be a one- column table that provides the values. Multiple -s entries allowed."
    inputBinding:
      position: 101
  - id: force_recalc
    type:
      - 'null'
      - boolean
    doc: "When set, re-calculate `pct_counts_<qc_variable>` and `pct_counts_in_top_<n>_genes` even if they exist."
    inputBinding:
      position: 101
      prefix: --force-recalc
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
      - name: filter_param_rec
        type: record
        fields:
          - name: name
            type: string
            inputBinding:
              position: 1
              prefix: -p
          - name: min
            type: float
            inputBinding:
              position: 2
          - name: max
            type: float
            inputBinding:
              position: 3
      - name: filter_category_rec
        type: record
        fields:
          - name: name
            type: string
            inputBinding:
              position: 1
              prefix: -c
          - name: values
            type: string
            inputBinding:
              position: 2
      - name: filter_subset_rec
        type: record
        fields:
          - name: name
            type: string
            inputBinding:
              position: 1
              prefix: -s
          - name: file
            type: File
            inputBinding:
              position: 2
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scanpy-scripts:1.9.301--pyhdfd78af_0
