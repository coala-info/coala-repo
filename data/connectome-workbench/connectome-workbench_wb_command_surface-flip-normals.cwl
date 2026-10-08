cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-flip-normals
label: connectome-workbench_wb_command_surface-flip-normals
doc: 'Flips all triangles on a surface, resulting in surface normals being flipped
  the other direction (inward vs outward). If you transform a surface with an affine
  that has negative determinant, or a warpfield that similarly flips the surface,
  you may end up with a surface that has normals pointing inwards, which may have
  display problems. Using this command will solve that problem.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to flip the normals of
    inputBinding:
      position: 1
  - id: surface_out
    type: string
    doc: output - the output surface
    inputBinding:
      position: 2
outputs:
  - id: surface_out_file
    type: File
    doc: the output surface
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
