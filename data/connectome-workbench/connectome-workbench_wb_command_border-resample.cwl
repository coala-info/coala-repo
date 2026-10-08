cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -border-resample
label: connectome-workbench_wb_command_border-resample
doc: "Resamples a border file, given two spherical surfaces that are in register. Only borders that have the same structure as current-sphere will be resampled.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: border_in
    type: File
    doc: the border file to resample
    inputBinding:
      position: 1
  - id: current_sphere
    type: File
    doc: a sphere surface with the mesh that the metric is currently on
    inputBinding:
      position: 2
  - id: new_sphere
    type: File
    doc: a sphere surface that is in register with <current-sphere> and has the desired output mesh
    inputBinding:
      position: 3
  - id: border_out
    type: string
    doc: the output border file
    inputBinding:
      position: 4
outputs:
  - id: border_out_file
    type: File
    doc: the output border file
    outputBinding:
      glob: $(inputs.border_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
