cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - prepare_data
  - prepare_GEX_ACC
label: scenicplus_prepare_GEX_ACC
doc: "Prepare scRNA-seq and scATAC-seq data. Returns a MuData file containing linked gene expression and chromatin accessibility data.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: cistopic_obj_fname
    type: File
    doc: "Path to cisTopic object pickle file."
    inputBinding:
      position: 101
      prefix: --cisTopic_obj_fname
  - id: gex_anndata_fname
    type: File
    doc: "Path to gene expression AnnData h5ad file."
    inputBinding:
      position: 101
      prefix: --GEX_anndata_fname
  - id: out_file_path
    type: string
    doc: "Out file name (MuData h5mu file)."
    inputBinding:
      position: 102
      prefix: --out_file
  - id: do_not_use_raw_for_gex_anndata
    type:
      - 'null'
      - boolean
    doc: "Do not use raw gene expression counts. Default is False"
    inputBinding:
      position: 101
      prefix: --do_not_use_raw_for_GEX_anndata
  - id: is_not_multiome
    type:
      - 'null'
      - boolean
    doc: "Data is not multiome. Default is False"
    inputBinding:
      position: 101
      prefix: --is_not_multiome
  - id: bc_transform_func
    type:
      - 'null'
      - string
    doc: "lambda function to transform gene expression cell barcodes into chromatin accessibility barcodes. Default is lambda x: x"
    inputBinding:
      position: 101
      prefix: --bc_transform_func
  - id: key_to_group_by
    type:
      - 'null'
      - string
    doc: "For non multi_ome_mode, use this cell metadata key to generate metacells from scRNA-seq and scATAC-seq. Key should be common in scRNA-seq and scATAC-seq side."
    inputBinding:
      position: 101
      prefix: --key_to_group_by
  - id: nr_metacells
    type:
      - 'null'
      - string
    doc: "For non multi_ome_mode, use this number of meta cells to link scRNA-seq and scATAC-seq If this is a single integer the same number of metacells will be used for all annotations. By default this number is determined automatically so that each cell is sampled at maximum twice."
    inputBinding:
      position: 101
      prefix: --nr_metacells
  - id: nr_cells_per_metacells
    type:
      - 'null'
      - string
    doc: "For non multi_ome_mode, use this number of cells per metacell to link scRNA-seq and scATAC-seq. If this is a single integer the same number of cells will be used for all annotations. Default is 10"
    inputBinding:
      position: 101
      prefix: --nr_cells_per_metacells
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Out file name (MuData h5mu file)."
    outputBinding:
      glob: "$(inputs.out_file_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
