cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - read
label: scanpy-scripts_scanpy-cli_read
doc: "Read 10x data and save in specified format.\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
inputs:
  - id: output_obj_path
    type: string
    doc: output file in format specified by --output-format
    inputBinding:
      position: 2
  - id: input_10x_h5
    type:
      - 'null'
      - File
    doc: "Input 10x data in Cell-Ranger hdf5 format."
    inputBinding:
      position: 101
      prefix: --input-10x-h5
  - id: input_10x_mtx
    type:
      - 'null'
      - Directory
    doc: "Path of input folder containing 10x data in mtx format."
    inputBinding:
      position: 101
      prefix: --input-10x-mtx
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
  - id: genome
    type:
      - 'null'
      - string
    doc: "Name of the genome group in hdf5 file, required by \"--input-10x-h5\"."
    inputBinding:
      position: 101
      prefix: --genome
  - id: var_names
    type:
      - 'null'
      - string
    doc: "Attribute to be used as the index of the variable table, required by \"-- input-10x-mtx\"."
    inputBinding:
      position: 101
      prefix: --var-names
  - id: extra_obs
    type:
      - 'null'
      - File
    doc: "Extra cell metadata table, must be tab- separated with a header row and an index column, and with matched dimension."
    inputBinding:
      position: 101
      prefix: --extra-obs
  - id: extra_var
    type:
      - 'null'
      - File
    doc: "Extra gene metadata table, must be tab- separated with a header row and an index column, and with matched dimension."
    inputBinding:
      position: 101
      prefix: --extra-var
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
