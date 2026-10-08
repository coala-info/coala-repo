cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-average
label: connectome-workbench_wb_command_cifti-average
doc: "Averages cifti files together. Files without -weight specified are given a weight of 1. If -exclude-outliers is specified, at each element, the data across all files is taken as a set, its unweighted mean and sample standard deviation are found, and values outside the specified number of standard deviations are excluded from the (potentially weighted) average at that element.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: cifti_item
        type: record
        fields:
          - name: cifti_in
            type: File
            doc: the input cifti file
            inputBinding:
              position: 1
              prefix: -cifti
          - name: weight
            type:
              - 'null'
              - float
            doc: the weight to use
            inputBinding:
              position: 2
              prefix: -weight
inputs:
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 1
  - id: exclude_outliers_sigma_below
    type:
      - 'null'
      - float
    doc: number of standard deviations below the mean to include
    inputBinding:
      position: 2
      prefix: -exclude-outliers
  - id: exclude_outliers_sigma_above
    type:
      - 'null'
      - float
    doc: number of standard deviations above the mean to include (give with exclude_outliers_sigma_below)
    inputBinding:
      position: 3
  - id: cifti
    type:
      - 'null'
      - type: array
        items: cifti_item
    doc: specify an input file (repeatable; one record per use of -cifti)
    inputBinding:
      position: 4
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
