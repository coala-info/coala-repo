cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-merge
label: connectome-workbench_wb_command_border-merge
doc: "Takes one or more border files and makes a new border file from the borders in them. Example: wb_command -border-merge out.border -border first.border -select 1 -border second.border This example would take the first border from first.border, followed by all borders from second.border, and write these to out.border.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: SchemaDefRequirement
    types:
      - name: select_item
        type: record
        fields:
          - name: border
            type: string
            doc: the border number or name
            inputBinding:
              position: 1
              prefix: -select
          - name: last_border
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
      - name: border_item
        type: record
        fields:
          - name: border_file_in
            type: File
            doc: a border file to use borders from
            inputBinding:
              position: 1
              prefix: -border
          - name: select
            type:
              - 'null'
              - type: array
                items: select_item
            doc: select a single border to use (repeatable)
            inputBinding:
              position: 2
inputs:
  - id: border_file_out
    type: string
    doc: the output border file
    inputBinding:
      position: 1
  - id: border
    type:
      - 'null'
      - type: array
        items: border_item
    doc: specify an input border file (repeatable; one record per use of -border)
    inputBinding:
      position: 2
outputs:
  - id: border_file_out_file
    type: File
    doc: the output border file
    outputBinding:
      glob: $(inputs.border_file_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
