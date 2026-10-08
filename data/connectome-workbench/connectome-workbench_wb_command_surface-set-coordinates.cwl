cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-set-coordinates
label: connectome-workbench_wb_command_surface-set-coordinates
doc: "Takes the topology from an existing surface file, and uses values from a metric file as coordinates to construct a new surface file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface_in
    type: File
    doc: "the surface to use for the topology"
    inputBinding:
      position: 1
  - id: coord_metric
    type: File
    doc: "the new coordinates, as a 3-column metric file"
    inputBinding:
      position: 2
  - id: surface_out
    type: string
    doc: "output - the new surface"
    inputBinding:
      position: 3
outputs:
  - id: output_surface
    type: File
    doc: "the new surface"
    outputBinding:
      glob: $(inputs.surface_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
