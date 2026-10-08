cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metric-extrema'
label: connectome-workbench_wb_command_metric-extrema
doc: "Find extrema in a metric file, such that no two extrema of the same type are within <distance> of each other. The extrema are labeled as -1 for minima, 1 for maxima, 0 otherwise.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: surface
    type: File
    doc: the surface to use for distance information
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the metric to find the extrema of
    inputBinding:
      position: 2
  - id: distance
    type: float
    doc: the minimum distance between identified extrema of the same type
    inputBinding:
      position: 3
  - id: metric_out
    type: string
    doc: output - the output extrema metric
    inputBinding:
      position: 4
  - id: presmooth
    type:
      - 'null'
      - float
    doc: smooth the metric before finding extrema; sigma for the gaussian kernel, in mm
    inputBinding:
      position: 5
      prefix: '-presmooth'
  - id: roi
    type:
      - 'null'
      - File
    doc: ignore values outside the selected area, as a metric
    inputBinding:
      position: 5
      prefix: '-roi'
  - id: threshold
    type:
      - 'null'
      - type: array
        items: float
    doc: 'ignore small extrema; two values: low (largest value to consider for a minimum), high (smallest value to consider for a maximum)'
    inputBinding:
      position: 5
      prefix: '-threshold'
  - id: sum_columns
    type:
      - 'null'
      - boolean
    doc: output the sum of the extrema columns instead of each column separately
    inputBinding:
      position: 5
      prefix: '-sum-columns'
  - id: consolidate_mode
    type:
      - 'null'
      - boolean
    doc: use consolidation of local minima instead of a large neighborhood
    inputBinding:
      position: 5
      prefix: '-consolidate-mode'
  - id: only_maxima
    type:
      - 'null'
      - boolean
    doc: only find the maxima
    inputBinding:
      position: 5
      prefix: '-only-maxima'
  - id: only_minima
    type:
      - 'null'
      - boolean
    doc: only find the minima
    inputBinding:
      position: 5
      prefix: '-only-minima'
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to find extrema in (number or name)
    inputBinding:
      position: 5
      prefix: '-column'
outputs:
  - id: extrema_metric
    type: File
    doc: the output extrema metric
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
