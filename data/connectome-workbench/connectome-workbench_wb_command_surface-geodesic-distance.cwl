cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-geodesic-distance
label: connectome-workbench_wb_command_surface-geodesic-distance
doc: 'Unless -limit is specified, computes the geodesic distance from the specified
  vertex to all others. The result is output as a single column metric file, with
  a value of -1 for vertices that the distance was not computed for.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 1
  - id: vertex
    type: int
    doc: the vertex to compute geodesic distance from
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 3
  - id: naive
    type:
      - 'null'
      - boolean
    doc: use only neighbors, don't crawl triangles (not recommended)
    inputBinding:
      position: 4
      prefix: -naive
  - id: limit
    type:
      - 'null'
      - float
    doc: stop at a certain distance
    inputBinding:
      position: 4
      prefix: -limit
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
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
