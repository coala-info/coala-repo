cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-cut-resample
label: connectome-workbench_wb_command_surface-cut-resample
doc: 'Resamples a surface file, given two spherical surfaces that are in register.
  Barycentric resampling is used, because it is usually better for resampling surfaces,
  and because it is needed to figure out the new topology anyway.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface_in
    type: File
    doc: the surface file to resample
    inputBinding:
      position: 1
  - id: current_sphere
    type: File
    doc: a sphere surface with the mesh that the input surface is currently on
    inputBinding:
      position: 2
  - id: new_sphere
    type: File
    doc: a sphere surface that is in register with <current-sphere> and has the desired
      output mesh
    inputBinding:
      position: 3
  - id: surface_out
    type: string
    doc: output - the output surface file
    inputBinding:
      position: 4
outputs:
  - id: surface_out_file
    type: File
    doc: the output surface file
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
