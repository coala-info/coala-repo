cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-coordinates-to-metric
label: connectome-workbench_wb_command_surface-coordinates-to-metric
doc: 'Puts the coordinates of the surface into a 3-map metric file, as x, y, z.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to use the coordinates of
    inputBinding:
      position: 1
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 2
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
