cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-vertex-areas
label: connectome-workbench_wb_command_surface-vertex-areas
doc: "Each vertex gets one third of the area of each triangle it is a part of. Units are mm^2.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: "the surface to measure"
    inputBinding:
      position: 1
  - id: metric
    type: string
    doc: "output - the output metric"
    inputBinding:
      position: 2
outputs:
  - id: vertex_areas
    type: File
    doc: "the output metric"
    outputBinding:
      glob: $(inputs.metric)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
