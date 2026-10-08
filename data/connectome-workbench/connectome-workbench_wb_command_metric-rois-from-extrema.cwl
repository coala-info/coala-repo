cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -metric-rois-from-extrema
label: connectome-workbench_wb_command_metric-rois-from-extrema
doc: 'For each nonzero value in each map, make a map with an ROI around that location.
  If the -gaussian option is specified, then normalized gaussian kernels are output
  instead of ROIs. The <method> argument to -overlap-logic must be one of ALLOW, CLOSEST,
  or EXCLUDE. ALLOW is the default, and means that ROIs are treated independently
  and may overlap. CLOSEST means that ROIs may not overlap, and that no ROI contains
  vertices that are closer to a different seed vertex. EXCLUDE means that ROIs may
  not overlap, and that any vertex within range of more than one ROI does not belong
  to any ROI.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
inputs:
  - id: surface
    type: File
    doc: the surface to use for geodesic distance
    inputBinding:
      position: 1
  - id: metric
    type: File
    doc: the input metric file
    inputBinding:
      position: 2
  - id: limit
    type: float
    doc: geodesic distance limit from vertex, in mm
    inputBinding:
      position: 3
  - id: metric_out
    type: string
    doc: output - the output metric file
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
  - id: roi
    type:
      - 'null'
      - File
    doc: select a region of interest to use
    inputBinding:
      position: 5
      prefix: -roi
  - id: overlap_logic
    type:
      - 'null'
      - string
    doc: how to handle overlapping ROIs, default ALLOW
    inputBinding:
      position: 5
      prefix: -overlap-logic
  - id: column
    type:
      - 'null'
      - string
    doc: select a single input column to use
    inputBinding:
      position: 5
      prefix: -column
outputs:
  - id: metric_out_file
    type: File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
