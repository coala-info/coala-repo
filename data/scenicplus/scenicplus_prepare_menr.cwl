cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - prepare_data
  - prepare_menr
label: scenicplus_prepare_menr
doc: "Prepare motif enrichment results: creates cistromes and the list of TF names.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: paths_to_motif_enrichment_results
    type:
      type: array
      items: File
    doc: "Paths to motif enrichment result hdf5 files (from pycistarget)."
    inputBinding:
      position: 101
      prefix: --paths_to_motif_enrichment_results
  - id: multiome_mudata_fname
    type: File
    doc: "Path to multiome MuData object (from scenicplus prepare_GEX_ACC)."
    inputBinding:
      position: 101
      prefix: --multiome_mudata_fname
  - id: out_file_tf_names_path
    type: string
    doc: "Out file name for TF names (txt file)."
    inputBinding:
      position: 102
      prefix: --out_file_tf_names
  - id: out_file_direct_annotation_path
    type:
      - 'null'
      - string
    doc: "Out file name for direct cistromes (AnnData h5ad file)."
    inputBinding:
      position: 102
      prefix: --out_file_direct_annotation
  - id: out_file_extended_annotation_path
    type:
      - 'null'
      - string
    doc: "Out file name for extended cistromes (AnnData h5ad file)."
    inputBinding:
      position: 102
      prefix: --out_file_extended_annotation
  - id: direct_annotation
    type:
      - 'null'
      - type: array
        items: string
    doc: "Annotations to use as direct. Default is 'Direct_annot'"
    inputBinding:
      position: 101
      prefix: --direct_annotation
  - id: extended_annotation
    type:
      - 'null'
      - type: array
        items: string
    doc: "Annotations to use as extended. Default is 'Orthology_annot'"
    inputBinding:
      position: 101
      prefix: --extended_annotation
outputs:
  - id: out_file_tf_names
    type:
      - 'null'
      - File
    doc: "Out file name for TF names (txt file)."
    outputBinding:
      glob: "$(inputs.out_file_tf_names_path)"
  - id: out_file_direct_annotation
    type:
      - 'null'
      - File
    doc: "Out file name for direct cistromes (AnnData h5ad file)."
    outputBinding:
      glob: "$(inputs.out_file_direct_annotation_path)"
  - id: out_file_extended_annotation
    type:
      - 'null'
      - File
    doc: "Out file name for extended cistromes (AnnData h5ad file)."
    outputBinding:
      glob: "$(inputs.out_file_extended_annotation_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
