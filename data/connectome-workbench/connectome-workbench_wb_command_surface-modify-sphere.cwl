cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-modify-sphere
label: connectome-workbench_wb_command_surface-modify-sphere
doc: 'This command may be useful if you have used -surface-resample to resample a
  sphere, which can suffer from problems generally not present in -surface-sphere-project-unproject.
  If the sphere should already be centered around the origin, using -recenter may
  still shift it slightly before changing the radius, which is likely to be undesireable.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: sphere_in
    type: File
    doc: the sphere to modify
    inputBinding:
      position: 1
  - id: radius
    type: float
    doc: the radius the output sphere should have
    inputBinding:
      position: 2
  - id: sphere_out
    type: string
    doc: output - the output sphere
    inputBinding:
      position: 3
  - id: recenter
    type:
      - 'null'
      - boolean
    doc: recenter the sphere by means of the bounding box
    inputBinding:
      position: 4
      prefix: -recenter
outputs:
  - id: sphere_out_file
    type: File
    doc: the output sphere
    outputBinding:
      glob: $(inputs.sphere_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
