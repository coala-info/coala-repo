cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-modify-keys'
label: connectome-workbench_wb_command_label-modify-keys
doc: "Change key values in a label file. <remap-file> has lines of the form 'oldkey newkey'. This does not change the appearance of the file when displayed.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input label file
    inputBinding:
      position: 1
  - id: remap_file
    type: File
    doc: text file with old and new key values
    inputBinding:
      position: 2
  - id: label_out
    type: string
    doc: output - output label file
    inputBinding:
      position: 3
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to use (number or name)
    inputBinding:
      position: 4
      prefix: '-column'
outputs:
  - id: modified_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
