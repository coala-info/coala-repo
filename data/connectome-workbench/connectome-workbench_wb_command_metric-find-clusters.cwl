cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-find-clusters
label: connectome-workbench_wb_command_metric-find-clusters
doc: 'Outputs a metric with nonzero integers for all vertices within a large enough
  cluster, and zeros elsewhere. The integers denote cluster membership (by default,
  first cluster found will use value 1, second cluster 2, etc). By default, values
  greater than <value-threshold> are considered to be in a cluster, use -less-than
  to test for values less than the threshold. To apply this as a mask to the data,
  or to do more complicated thresholding, see -metric-math.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to compute on
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the input metric
    inputBinding:
      position: 2
  - id: value_threshold
    type: float
    doc: threshold for data values
    inputBinding:
      position: 3
  - id: minimum_area
    type: float
    doc: threshold for cluster area, in mm^2
    inputBinding:
      position: 4
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 5
  - id: less_than
    type:
      - 'null'
      - boolean
    doc: find values less than <value-threshold>, rather than greater
    inputBinding:
      position: 6
      prefix: -less-than
  - id: roi
    type:
      - 'null'
      - File
    doc: select a region of interest
    inputBinding:
      position: 6
      prefix: -roi
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 6
      prefix: -corrected-areas
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column
    inputBinding:
      position: 6
      prefix: -column
  - id: size_ratio
    type:
      - 'null'
      - float
    doc: ignore clusters smaller than a given fraction of the largest cluster in map
    inputBinding:
      position: 6
      prefix: -size-ratio
  - id: distance
    type:
      - 'null'
      - float
    doc: ignore clusters further than a given distance from the largest cluster
    inputBinding:
      position: 6
      prefix: -distance
  - id: start
    type:
      - 'null'
      - int
    doc: start labeling clusters from a value other than 1
    inputBinding:
      position: 6
      prefix: -start
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
