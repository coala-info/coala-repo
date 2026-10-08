cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-information
label: connectome-workbench_wb_command_surface-information
doc: 'Information about surface is displayed including vertices, triangles, bounding
  box, and spacing.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface_file
    type: File
    doc: Surface for which information is displayed
    inputBinding:
      position: 1
  - id: output_name
    type: string
    default: surface-information.txt
    doc: name of the file that receives the printed output
outputs:
  - id: output
    type: File
    doc: the printed output
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
