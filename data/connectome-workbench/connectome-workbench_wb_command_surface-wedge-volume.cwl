cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-wedge-volume
label: connectome-workbench_wb_command_surface-wedge-volume
doc: "Compute the volume of each vertex's area from one surface to another. The surfaces must have vertex correspondence.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: inner_surface
    type: File
    doc: "the inner surface"
    inputBinding:
      position: 1
  - id: outer_surface
    type: File
    doc: "the outer surface"
    inputBinding:
      position: 2
  - id: metric
    type: string
    doc: "output - the output metric"
    inputBinding:
      position: 3
outputs:
  - id: wedge_volumes
    type: File
    doc: "the output metric"
    outputBinding:
      glob: $(inputs.metric)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
