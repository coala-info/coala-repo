cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -surface-geodesic-rois
label: connectome-workbench_wb_command_surface-geodesic-rois
doc: 'For each vertex in the list file, a column in the output metric is created,
  and an ROI around that vertex is drawn in that column. Each metric column will have
  zeros outside the geodesic distance spacified by <limit>, and by default will have
  a value of 1.0 inside it. If the -gaussian option is specified, the values inside
  the ROI will instead form a gaussian with the specified value of sigma, normalized
  so that the sum of the nonzero values in the metric column is 1.0. The <method>
  argument to -overlap-logic must be one of ALLOW, CLOSEST, or EXCLUDE. ALLOW is the
  default, and means that ROIs are treated independently and may overlap. CLOSEST
  means that ROIs may not overlap, and that no ROI contains vertices that are closer
  to a different seed vertex. EXCLUDE means that ROIs may not overlap, and that any
  vertex within range of more than one ROI does not belong to any ROI.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to draw on
    inputBinding:
      position: 1
  - id: limit
    type: float
    doc: geodesic distance limit from vertex, in mm
    inputBinding:
      position: 2
  - id: vertex_list_file
    type: File
    doc: a text file containing the vertices to draw ROIs around
    inputBinding:
      position: 3
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 4
  - id: gaussian
    type:
      - 'null'
      - float
    doc: generate a gaussian kernel instead of a flat ROI
    inputBinding:
      position: 5
      prefix: -gaussian
  - id: overlap_logic
    type:
      - 'null'
      - string
    doc: how to handle overlapping ROIs, default ALLOW
    inputBinding:
      position: 5
      prefix: -overlap-logic
  - id: names
    type:
      - 'null'
      - File
    doc: name the columns from text file
    inputBinding:
      position: 5
      prefix: -names
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 5
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
