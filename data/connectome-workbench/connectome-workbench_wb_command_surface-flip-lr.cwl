cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-flip-lr
label: connectome-workbench_wb_command_surface-flip-lr
doc: 'This command negates the x coordinate of each vertex, and flips the surface
  normals, so that you have a surface of opposite handedness with the same features
  and vertex correspondence, with normals consistent with the original surface. That
  is, if the input surface has normals facing outward, the output surface will also
  have normals facing outward.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to flip
    inputBinding:
      position: 1
  - id: surface_out
    type: string
    doc: output - the output flipped surface
    inputBinding:
      position: 2
outputs:
  - id: surface_out_file
    type: File
    doc: the output flipped surface
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
