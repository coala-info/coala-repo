cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-parcel-mapping-to-label
label: connectome-workbench_wb_command_cifti-parcel-mapping-to-label
doc: "This command will output a dlabel file, useful for doing the same parcellation to another dense file. For ptseries, pscalar, plabel, pconn, and pdconn, using COLUMN for <direction> will work.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the input parcellated file
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which dimension to take the parcel map from, ROW or COLUMN
    inputBinding:
      position: 2
  - id: template_cifti
    type: File
    doc: a cifti file with the desired dense mapping along column
    inputBinding:
      position: 3
  - id: dlabel_out
    type: string
    doc: the output dense label file
    inputBinding:
      position: 4
outputs:
  - id: dlabel_out_file
    type: File
    doc: the output dense label file
    outputBinding:
      glob: $(inputs.dlabel_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
