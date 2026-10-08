cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-match
label: connectome-workbench_wb_command_surface-match
doc: 'The Input Surface File will be transformed so that its coordinate ranges (bounding
  box) match that of the Match Surface File


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: match_surface_file
    type: File
    doc: Match (Reference) Surface
    inputBinding:
      position: 1
  - id: input_surface_file
    type: File
    doc: File containing surface that will be transformed
    inputBinding:
      position: 2
  - id: output_surface_name
    type: string
    doc: output - Surface File after transformation
    inputBinding:
      position: 3
outputs:
  - id: output_surface_name_file
    type: File
    doc: Surface File after transformation
    outputBinding:
      glob: $(inputs.output_surface_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
