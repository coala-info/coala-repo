cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-rois-from-extrema'
label: connectome-workbench_wb_command_cifti-rois-from-extrema
doc: "Create cifti ROI maps from extrema maps. For each nonzero value in each map, make a map with an ROI around that location. If -gaussian is specified, normalized gaussian kernels are output instead of ROIs. The -overlap-logic method must be one of ALLOW (default), CLOSEST, or EXCLUDE.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: surf_limit
    type: float
    doc: geodesic distance limit from vertex, in mm
    inputBinding:
      position: 2
  - id: vol_limit
    type: float
    doc: euclidean distance limit from voxel center, in mm
    inputBinding:
      position: 3
  - id: direction
    type: string
    doc: which dimension an extrema map is along, ROW or COLUMN
    inputBinding:
      position: 4
  - id: cifti_out
    type: string
    doc: output - the output cifti
    inputBinding:
      position: 5
  - id: left_surface
    type:
      - 'null'
      - File
    doc: the left surface file
    inputBinding:
      position: 10
      prefix: '-left-surface'
  - id: right_surface
    type:
      - 'null'
      - File
    doc: the right surface file
    inputBinding:
      position: 11
      prefix: '-right-surface'
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: the cerebellum surface file
    inputBinding:
      position: 12
      prefix: '-cerebellum-surface'
  - id: gaussian
    type:
      - 'null'
      - type: array
        items: float
    doc: 'generate gaussian kernels instead of flat ROIs; two values: surface sigma, volume sigma (mm)'
    inputBinding:
      position: 13
      prefix: '-gaussian'
  - id: overlap_logic
    type:
      - 'null'
      - string
    doc: 'how to handle overlapping ROIs: ALLOW (default), CLOSEST or EXCLUDE'
    inputBinding:
      position: 14
      prefix: '-overlap-logic'
  - id: merged_volume
    type:
      - 'null'
      - boolean
    doc: treat volume components as if they were a single component
    inputBinding:
      position: 15
      prefix: '-merged-volume'
outputs:
  - id: roi_cifti
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
