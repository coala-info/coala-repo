cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-gradient
label: connectome-workbench_wb_command_metric-gradient
doc: 'At each vertex, the immediate neighbors are unfolded onto a plane tangent to
  the surface at the vertex (specifically, perpendicular to the normal). The gradient
  is computed using a regression between the unfolded positions of the vertices and
  their values. The gradient is then given by the slopes of the regression, and reconstructed
  as a 3D gradient vector. By default, takes the gradient of all columns, with no
  presmoothing, across the whole surface, without averaging the normals of the surface
  among neighbors.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: roi_rec
        type: record
        fields:
          - name: roi_metric
            type: File
            doc: the area to take the gradient within, as a metric
            inputBinding:
              position: 1
          - name: match_columns
            type:
              - 'null'
              - boolean
            doc: for each input column, use the corresponding column from the roi
            inputBinding:
              position: 2
              prefix: -match-columns
inputs:
  - id: surface
    type: File
    doc: the surface to compute the gradient on
    inputBinding:
      position: 1
  - id: metric_in
    type: File
    doc: the metric to compute the gradient of
    inputBinding:
      position: 2
  - id: metric_out
    type: string
    doc: output - the magnitude of the gradient
    inputBinding:
      position: 3
  - id: presmooth
    type:
      - 'null'
      - float
    doc: smooth the metric before computing the gradient
    inputBinding:
      position: 4
      prefix: -presmooth
  - id: roi
    type:
      - 'null'
      - roi_rec
    doc: select a region of interest to take the gradient of
    inputBinding:
      position: 4
      prefix: -roi
  - id: vectors
    type:
      - 'null'
      - string
    doc: output gradient vectors
    inputBinding:
      position: 4
      prefix: -vectors
  - id: column
    type:
      - 'null'
      - string
    doc: select a single column to compute the gradient of
    inputBinding:
      position: 4
      prefix: -column
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: vertex areas to use instead of computing them from the surface
    inputBinding:
      position: 4
      prefix: -corrected-areas
  - id: average_normals
    type:
      - 'null'
      - boolean
    doc: average the normals of each vertex with its neighbors before using them to
      compute the gradient
    inputBinding:
      position: 4
      prefix: -average-normals
outputs:
  - id: metric_out_file
    type: File
    doc: the magnitude of the gradient
    outputBinding:
      glob: $(inputs.metric_out)
  - id: vectors_file
    type:
      - 'null'
      - File
    doc: the vectors as a metric file
    outputBinding:
      glob: $(inputs.vectors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
