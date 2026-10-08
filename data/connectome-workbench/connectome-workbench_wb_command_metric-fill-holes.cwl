cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-fill-holes
label: connectome-workbench_wb_command_metric-fill-holes
doc: 'Finds all connected areas that are not included in the ROI, and writes ones
  into all but the largest one, in terms of surface area.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to use for neighbor information
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the input ROI metric
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output ROI metric
    inputBinding:
      position: 3
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 4
      prefix: -corrected-areas
outputs:
  - id: metric_out_file
    type: File
    doc: the output ROI metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
