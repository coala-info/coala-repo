cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mhca
  - update_feature_table
label: mhc-annotation_mhca_update_feature_table
doc: "Update records in a feature table with the features of another feature table.\n\nTool homepage:\
  \ https://github.com/DiltheyLab/MHC-annotation"
inputs:
  - id: old_feature_table
    type: File
    doc: Old feature table file.
    inputBinding:
      position: 1
  - id: record_id
    type: string
    doc: ID of record that will be updated.
    inputBinding:
      position: 2
  - id: update_feature_table
    type: File
    doc: Feature table file with new features.
    inputBinding:
      position: 3
  - id: new_feature_table
    type: string
    doc: New updated feature table file (name to write).
    inputBinding:
      position: 4
outputs:
  - id: new_table
    type: File
    doc: New updated feature table.
    outputBinding:
      glob: $(inputs.new_feature_table)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mhc-annotation:0.1.1--pyhdfd78af_1
