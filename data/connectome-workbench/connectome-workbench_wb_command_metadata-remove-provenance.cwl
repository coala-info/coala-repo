cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metadata-remove-provenance'
label: connectome-workbench_wb_command_metadata-remove-provenance
doc: "Remove the provenance metadata fields added by workbench during processing.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: input_file
    type: File
    doc: the file to remove provenance information from
    inputBinding:
      position: 1
  - id: output_file
    type: string
    doc: output - the name to save the modified file as
    inputBinding:
      position: 2
outputs:
  - id: cleaned_file
    type: File
    doc: the modified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
