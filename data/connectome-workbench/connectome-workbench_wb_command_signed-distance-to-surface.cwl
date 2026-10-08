cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -signed-distance-to-surface
label: connectome-workbench_wb_command_signed-distance-to-surface
doc: 'Compute the signed distance function of the reference surface at every vertex
  on the comparison surface. NOTE: this relation is NOT symmetric, the line from a
  vertex to the closest point on the ''ref'' surface (the one that defines the signed
  distance function) will only align with the normal of the ''ref'' surface. Valid
  specifiers for winding methods are as follows:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface_comp
    type: File
    doc: the comparison surface to measure the signed distance on
    inputBinding:
      position: 1
  - id: surface_ref
    type: File
    doc: the reference surface that defines the signed distance function
    inputBinding:
      position: 2
  - id: metric
    type: string
    doc: output - the output metric
    inputBinding:
      position: 3
  - id: winding
    type:
      - 'null'
      - string
    doc: winding method for point inside surface test
    inputBinding:
      position: 4
      prefix: -winding
outputs:
  - id: metric_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
