cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-closest-vertex
label: connectome-workbench_wb_command_surface-closest-vertex
doc: 'For each coordinate XYZ triple, find the closest vertex in the surface, and
  output its vertex number into a text file. The input file should only use whitespace
  to separate coordinates (spaces, newlines, tabs), for instance:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to use
    inputBinding:
      position: 1
  - id: coord_list_file
    type: File
    doc: text file with coordinates
    inputBinding:
      position: 2
  - id: vertex_list_out
    type: string
    doc: output - the output text file with vertex numbers
    inputBinding:
      position: 3
outputs:
  - id: vertex_list_out_file
    type: File
    doc: the output text file with vertex numbers
    outputBinding:
      glob: $(inputs.vertex_list_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
