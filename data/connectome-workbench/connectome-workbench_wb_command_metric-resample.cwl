cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-resample
label: connectome-workbench_wb_command_metric-resample
doc: 'Resamples a metric file, given two spherical surfaces that are in register.
  If ADAP_BARY_AREA is used, exactly one of -area-surfs or -area-metrics must be specified.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: area_surfs_rec
        type: record
        fields:
          - name: current_area
            type: File
            doc: a relevant anatomical surface with <current-sphere> mesh
            inputBinding:
              position: 1
          - name: new_area
            type: File
            doc: a relevant anatomical surface with <new-sphere> mesh
            inputBinding:
              position: 2
      - name: area_metrics_rec
        type: record
        fields:
          - name: current_area
            type: File
            doc: a metric file with vertex areas for <current-sphere> mesh
            inputBinding:
              position: 1
          - name: new_area
            type: File
            doc: a metric file with vertex areas for <new-sphere> mesh
            inputBinding:
              position: 2
inputs:
  - id: metric_in
    type: File
    doc: the metric file to resample
    inputBinding:
      position: 1
  - id: current_sphere
    type: File
    doc: a sphere surface with the mesh that the metric is currently on
    inputBinding:
      position: 2
  - id: new_sphere
    type: File
    doc: a sphere surface that is in register with <current-sphere> and has the desired
      output mesh
    inputBinding:
      position: 3
  - id: method
    type: string
    doc: the method name
    inputBinding:
      position: 4
  - id: metric_out
    type: string
    doc: output - the output metric
    inputBinding:
      position: 5
  - id: area_surfs
    type:
      - 'null'
      - area_surfs_rec
    doc: specify surfaces to do vertex area correction based on
    inputBinding:
      position: 6
      prefix: -area-surfs
  - id: area_metrics
    type:
      - 'null'
      - area_metrics_rec
    doc: specify vertex area metrics to do area correction based on
    inputBinding:
      position: 6
      prefix: -area-metrics
  - id: current_roi
    type:
      - 'null'
      - File
    doc: use an input roi on the current mesh to exclude non-data vertices
    inputBinding:
      position: 6
      prefix: -current-roi
  - id: valid_roi_out
    type:
      - 'null'
      - string
    doc: output the ROI of vertices that got data from valid source vertices
    inputBinding:
      position: 6
      prefix: -valid-roi-out
  - id: largest
    type:
      - 'null'
      - boolean
    doc: use only the value of the vertex with the largest weight
    inputBinding:
      position: 6
      prefix: -largest
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric
    outputBinding:
      glob: $(inputs.metric_out)
  - id: valid_roi_out_file
    type:
      - 'null'
      - File
    doc: the output roi as a metric
    outputBinding:
      glob: $(inputs.valid_roi_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
