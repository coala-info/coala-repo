cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-geodesic-distance-all-to-all
label: connectome-workbench_wb_command_surface-geodesic-distance-all-to-all
doc: 'Computes geodesic distance from every vertex to every vertex, outputting a single-hemisphere
  dconn file. If you are only interested in a few vertices, see -surface-geodesic-distance.
  When -limit is specified, any vertex beyond the limit is assigned the value -1.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: output - single-hemisphere dconn containing the distances
    inputBinding:
      position: 2
  - id: roi
    type:
      - 'null'
      - File
    doc: only output distances for vertices inside an ROI
    inputBinding:
      position: 3
      prefix: -roi
  - id: limit
    type:
      - 'null'
      - float
    doc: stop at a specified distance
    inputBinding:
      position: 3
      prefix: -limit
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 3
      prefix: -corrected-areas
  - id: naive
    type:
      - 'null'
      - boolean
    doc: use only neighbors, don't crawl triangles (not recommended)
    inputBinding:
      position: 3
      prefix: -naive
outputs:
  - id: cifti_out_file
    type: File
    doc: single-hemisphere dconn containing the distances
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
