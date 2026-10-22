cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
  - create_scplus_mudata
label: scenicplus_create_scplus_mudata
doc: "Create the final SCENIC+ MuData object from eRegulon AUC values and metadata.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: multiome_mudata_fname
    type: File
    doc: "Path to MuData containing gene expression and chromatin accessibility data (.h5mu)"
    inputBinding:
      position: 101
      prefix: --multiome_mudata_fname
  - id: e_regulon_auc_direct_mudata_fname
    type: File
    doc: "Path to MuData containing AUC values for direct eRegulons (.h5mu)"
    inputBinding:
      position: 101
      prefix: --e_regulon_auc_direct_mudata_fname
  - id: e_regulon_auc_extended_mudata_fname
    type: File
    doc: "Path to MuData containing AUC values for extended eRegulons (.h5mu)"
    inputBinding:
      position: 101
      prefix: --e_regulon_auc_extended_mudata_fname
  - id: e_regulon_metadata_direct_fname
    type: File
    doc: "Path to tsv containing metadata for direct eRegulons (.tsv)"
    inputBinding:
      position: 101
      prefix: --e_regulon_metadata_direct_fname
  - id: e_regulon_metadata_extended_fname
    type: File
    doc: "Path to tsv containing metadata for extended eRegulons (.tsv)"
    inputBinding:
      position: 101
      prefix: --e_regulon_metadata_extended_fname
  - id: out_file_path
    type: string
    doc: "Path to store resulting MuData (.h5mu)"
    inputBinding:
      position: 102
      prefix: --out_file
outputs:
  - id: out_file
    type:
      - 'null'
      - File
    doc: "Path to store resulting MuData (.h5mu)"
    outputBinding:
      glob: "$(inputs.out_file_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
