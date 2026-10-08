cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-create-sphere
label: connectome-workbench_wb_command_surface-create-sphere
doc: 'Generates a sphere by regularly dividing the triangles of an icosahedron, to
  come as close to the desired number of vertices as possible, and modifying it to
  have very similar vertex areas for all vertices. To generate a pair of vertex-matched
  left and right spheres, use this command, then -surface-flip-lr to generate the
  other sphere, then -set-structure on each. For example:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: num_vertices
    type: int
    doc: desired number of vertices
    inputBinding:
      position: 1
  - id: sphere_out
    type: string
    doc: output - the output sphere
    inputBinding:
      position: 2
outputs:
  - id: sphere_out_file
    type: File
    doc: the output sphere
    outputBinding:
      glob: $(inputs.sphere_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
