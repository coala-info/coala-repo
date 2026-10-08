cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-label-resample'
label: connectome-workbench_wb_command_label-resample
doc: "Resample a label file to a different mesh, given two spherical surfaces that are in register. If ADAP_BARY_AREA is used, exactly one of -area-surfs or -area-metrics must be specified. The method must be ADAP_BARY_AREA or BARYCENTRIC.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the label file to resample
    inputBinding:
      position: 1
  - id: current_sphere
    type: File
    doc: a sphere surface with the mesh that the label file is currently on
    inputBinding:
      position: 2
  - id: new_sphere
    type: File
    doc: a sphere surface that is in register with <current-sphere> and has the desired output mesh
    inputBinding:
      position: 3
  - id: method
    type: string
    doc: 'the method name: ADAP_BARY_AREA or BARYCENTRIC'
    inputBinding:
      position: 4
  - id: label_out
    type: string
    doc: output - the output label file
    inputBinding:
      position: 5
  - id: area_surfs
    type:
      - 'null'
      - type: array
        items: File
    doc: 'surfaces for vertex area correction; two files: anatomical surface with current mesh, with new mesh'
    inputBinding:
      position: 6
      prefix: '-area-surfs'
  - id: area_metrics
    type:
      - 'null'
      - type: array
        items: File
    doc: 'vertex area metrics for area correction; two files: areas for current mesh, for new mesh'
    inputBinding:
      position: 6
      prefix: '-area-metrics'
  - id: current_roi
    type:
      - 'null'
      - File
    doc: an input roi on the current mesh to exclude non-data vertices, as a metric
    inputBinding:
      position: 6
      prefix: '-current-roi'
  - id: valid_roi_out
    type:
      - 'null'
      - string
    doc: output - the ROI of vertices that got data from valid source vertices
    inputBinding:
      position: 6
      prefix: '-valid-roi-out'
  - id: largest
    type:
      - 'null'
      - boolean
    doc: use only the label of the vertex with the largest weight
    inputBinding:
      position: 6
      prefix: '-largest'
outputs:
  - id: resampled_label
    type: File
    doc: the output label file
    outputBinding:
      glob: $(inputs.label_out)
  - id: valid_roi
    type:
      - 'null'
      - File
    doc: the output roi as a metric
    outputBinding:
      glob: $(inputs.valid_roi_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
