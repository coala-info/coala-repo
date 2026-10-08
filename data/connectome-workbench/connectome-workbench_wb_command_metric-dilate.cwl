cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metric-dilate'
label: connectome-workbench_wb_command_metric-dilate
doc: "Dilate a metric file. For all metric vertices that are designated as bad, if they neighbor a non-bad vertex with data or are within the specified distance of such a vertex, replace the value with a distance weighted average of nearby non-bad vertices that have data, otherwise set the value to zero.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: metric
    type: File
    doc: the metric to dilate
    inputBinding:
      position: 1
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 2
  - id: distance
    type: float
    doc: distance in mm to dilate
    inputBinding:
      position: 3
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 4
  - id: bad_vertex_roi
    type:
      - 'null'
      - File
    doc: metric file, positive values denote vertices to have their values replaced
    inputBinding:
      position: 5
      prefix: '-bad-vertex-roi'
  - id: data_roi
    type:
      - 'null'
      - File
    doc: metric file, positive values denote vertices that have data
    inputBinding:
      position: 5
      prefix: '-data-roi'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to dilate (number or name)
    inputBinding:
      position: 5
      prefix: '-column'
  - id: nearest
    type:
      - 'null'
      - boolean
    doc: use the nearest good value instead of a weighted average
    inputBinding:
      position: 5
      prefix: '-nearest'
  - id: linear
    type:
      - 'null'
      - boolean
    doc: fill in values with linear interpolation along strongest gradient
    inputBinding:
      position: 5
      prefix: '-linear'
  - id: exponent
    type:
      - 'null'
      - float
    doc: exponent n to use in (area / (distance ^ n)) as the weighting function (default 2)
    inputBinding:
      position: 5
      prefix: '-exponent'
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface, as a metric
    inputBinding:
      position: 5
      prefix: '-corrected-areas'
outputs:
  - id: dilated_metric
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
