cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-normals
label: connectome-workbench_wb_command_surface-normals
doc: "Computes the normal vectors of the surface file, and outputs them as a 3 column metric file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: "the surface to output the normals of"
    inputBinding:
      position: 1
  - id: metric_out
    type: string
    doc: "output - the normal vectors"
    inputBinding:
      position: 2
outputs:
  - id: normals_metric
    type: File
    doc: "the normal vectors"
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
