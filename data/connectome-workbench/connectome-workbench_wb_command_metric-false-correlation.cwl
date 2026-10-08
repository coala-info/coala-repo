cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metric-false-correlation'
label: connectome-workbench_wb_command_metric-false-correlation
doc: "Compare correlation locally and across/through sulci/gyri. For each vertex, compute the average correlation within a range of geodesic distances that don't cross a sulcus/gyrus, and the correlation to the closest vertex crossing a sulcus/gyrus. The output contains the ratio between these correlations, and additional maps to help explain the ratio.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: the surface to compute geodesic and 3D distance with
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the metric to correlate
    inputBinding:
      position: 2
  - id: dist_3d
    type: float
    doc: maximum 3D distance to check around each vertex
    inputBinding:
      position: 3
  - id: geo_outer
    type: float
    doc: maximum geodesic distance to use for neighboring correlation
    inputBinding:
      position: 4
  - id: geo_inner
    type: float
    doc: minimum geodesic distance to use for neighboring correlation
    inputBinding:
      position: 5
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 6
  - id: roi
    type:
      - 'null'
      - File
    doc: select a region of interest that has data, as a metric file
    inputBinding:
      position: 7
      prefix: '-roi'
  - id: dump_text
    type:
      - 'null'
      - string
    doc: dump the raw measures used to this text file
    inputBinding:
      position: 7
      prefix: '-dump-text'
outputs:
  - id: correlation_metric
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
  - id: raw_measures
    type:
      - 'null'
      - File
    doc: the dumped raw measures text file
    outputBinding:
      glob: $(inputs.dump_text)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
