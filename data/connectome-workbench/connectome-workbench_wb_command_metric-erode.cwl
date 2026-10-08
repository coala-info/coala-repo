cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metric-erode'
label: connectome-workbench_wb_command_metric-erode
doc: "Erode a metric file. Around each vertex with a value of zero, set surrounding vertices to zero. The surrounding vertices are all immediate neighbors and all vertices within the specified distance.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: metric
    type: File
    doc: the metric file to erode
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 2
  - id: distance
    type: float
    doc: distance in mm to erode
    inputBinding:
      position: 3
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 4
  - id: roi
    type:
      - 'null'
      - File
    doc: assume values outside this roi are nonzero; metric file, positive values denote vertices that have data
    inputBinding:
      position: 5
      prefix: '-roi'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to erode (number or name)
    inputBinding:
      position: 5
      prefix: '-column'
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface, as a metric
    inputBinding:
      position: 5
      prefix: '-corrected-areas'
outputs:
  - id: eroded_metric
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
