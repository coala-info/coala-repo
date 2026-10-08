cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-foci-get-projection-vertex'
label: connectome-workbench_wb_command_foci-get-projection-vertex
doc: "Get projection vertex for foci. For each focus, a column is created in <metric-out>, and the vertex with the most influence on its projection is assigned a value of 1 in that column, with all other vertices 0. If -name is used, only one focus will be used.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: foci
    type: File
    doc: the foci file
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface related to the foci file
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric file
    inputBinding:
      position: 3
  - id: name
    type:
      - 'null'
      - string
    doc: select a focus by name
    inputBinding:
      position: 4
      prefix: '-name'
outputs:
  - id: projection_metric
    type: File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
