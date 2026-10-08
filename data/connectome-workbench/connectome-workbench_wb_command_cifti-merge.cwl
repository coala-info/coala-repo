cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-merge
label: connectome-workbench_wb_command_cifti-merge
doc: "Given input CIFTI files which have matching mappings along columns, and for which mappings along rows are the same type, all either series, scalars, or labels, this command concatenates the specified columns horizontally (rows become longer). Example: wb_command -cifti-merge out.dtseries.nii -cifti first.dtseries.nii -column 1 -cifti second.dtseries.nii This example would take the first column from first.dtseries.nii, followed by all columns from second.dtseries.nii, and write these columns to out.dtseries.nii.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: column_item
        type: record
        fields:
          - name: column
            type: string
            doc: the column number (starting from 1) or name
            inputBinding:
              position: 1
              prefix: -column
          - name: last_column
            type:
              - 'null'
              - string
            doc: the number or name of the last column to include
            inputBinding:
              position: 2
              prefix: -up-to
          - name: reverse
            type:
              - 'null'
              - boolean
            doc: use the range in reverse order
            inputBinding:
              position: 3
              prefix: -reverse
      - name: cifti_item
        type: record
        fields:
          - name: cifti_in
            type: File
            doc: a cifti file to use columns from
            inputBinding:
              position: 1
              prefix: -cifti
          - name: column
            type:
              - 'null'
              - type: array
                items: column_item
            doc: select a single column to use (repeatable)
            inputBinding:
              position: 2
inputs:
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 1
  - id: cifti
    type:
      - 'null'
      - type: array
        items: cifti_item
    doc: specify an input cifti file (repeatable; one record per use of -cifti)
    inputBinding:
      position: 2
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
