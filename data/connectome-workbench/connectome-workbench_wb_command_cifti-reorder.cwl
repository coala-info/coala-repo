cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-reorder
label: connectome-workbench_wb_command_cifti-reorder
doc: "The mapping along the specified direction must be parcels, scalars, or labels. For pscalar or ptseries, use COLUMN to reorder the parcels. For dlabel, use ROW. The <reorder-list> file must contain 1-based indices separated by whitespace (spaces, newlines, tabs, etc), with as many indices as <cifti-in> has along the specified dimension. These indices specify which current index should end up in that position, for instance, if the current order is 'A B C D', and the desired order is 'D A B C', the text file should contain '4 1 2 3'.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: input cifti file
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which dimension to reorder along, ROW or COLUMN
    inputBinding:
      position: 2
  - id: reorder_list
    type: File
    doc: a text file containing the desired order transformation
    inputBinding:
      position: 3
  - id: cifti_out
    type: string
    doc: the reordered cifti file
    inputBinding:
      position: 4
outputs:
  - id: cifti_out_file
    type: File
    doc: the reordered cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
