cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scanpy-cli
  - multiplet
  - scrublet_simulate_doublets
label: scanpy-scripts_scanpy-cli_multiplet_scrublet_simulate_doublets
doc: "Simulate doublets with random transcriptome pairs for Scrublet [Wolock2019].\n\nTool homepage: https://github.com/ebi-gene-expression-group/scanpy-scripts"
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
  - id: sim_doublet_ratio
    type:
      - 'null'
      - float
    doc: "Number of doublets to simulate relative to the number of observed transcriptomes."
    inputBinding:
      position: 101
      prefix: --sim-doublet-ratio
  - id: synthetic_doublet_umi_subsampling
    type:
      - 'null'
      - float
    doc: "Where input_obj_sim not suplied, rate for sampling UMIs when creating synthetic doublets. If 1.0, each doublet is created by simply adding the UMI counts from two randomly sampled observed transcriptomes. For values less than 1, the UMI counts are added and then randomly sampled at the specified rate."
    inputBinding:
      position: 101
      prefix: --synthetic-doublet-umi-subsampling
  - id: layer
    type:
      - 'null'
      - string
    doc: "Layer of adata where raw values are stored, or ‘X’ if values are in .X."
    inputBinding:
      position: 101
      prefix: --layer
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
