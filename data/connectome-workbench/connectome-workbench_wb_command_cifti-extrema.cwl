cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-extrema
label: connectome-workbench_wb_command_cifti-extrema
doc: "Finds spatial locations in a cifti file that have more extreme values than all nearby locations in the same component (surface or volume structure). The input cifti file must have a brain models mapping along the specified direction. COLUMN is the direction that works on dtseries and dscalar. For dconn, if it is symmetric use COLUMN, otherwise use ROW.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: surface_distance
    type: float
    doc: the minimum distance between extrema of the same type, for surface components
    inputBinding:
      position: 2
  - id: volume_distance
    type: float
    doc: the minimum distance between extrema of the same type, for volume components
    inputBinding:
      position: 3
  - id: direction
    type: string
    doc: which dimension to find extrema along, ROW or COLUMN
    inputBinding:
      position: 4
  - id: cifti_out
    type: string
    doc: the output cifti
    inputBinding:
      position: 5
  - id: left_surface
    type:
      - 'null'
      - File
    doc: 'specify the left surface to use: the left surface file'
    inputBinding:
      position: 6
      prefix: -left-surface
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 7
      prefix: -right-surface
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 8
      prefix: -cerebellum-surface
  - id: surface_presmooth
    type:
      - 'null'
      - float
    doc: 'smooth on the surface before finding extrema: the sigma for the gaussian surface smoothing kernel, in mm'
    inputBinding:
      position: 9
      prefix: -surface-presmooth
  - id: volume_presmooth
    type:
      - 'null'
      - float
    doc: 'smooth volume components before finding extrema: the sigma for the gaussian volume smoothing kernel, in mm'
    inputBinding:
      position: 10
      prefix: -volume-presmooth
  - id: threshold_low
    type:
      - 'null'
      - float
    doc: the largest value to consider for being a minimum
    inputBinding:
      position: 11
      prefix: -threshold
  - id: threshold_high
    type:
      - 'null'
      - float
    doc: the smallest value to consider for being a maximum (give with threshold_low)
    inputBinding:
      position: 12
  - id: merged_volume
    type:
      - 'null'
      - boolean
    doc: treat volume components as if they were a single component
    inputBinding:
      position: 13
      prefix: -merged-volume
  - id: sum_maps
    type:
      - 'null'
      - boolean
    doc: output the sum of the extrema maps instead of each map separately
    inputBinding:
      position: 14
      prefix: -sum-maps
  - id: consolidate_mode
    type:
      - 'null'
      - boolean
    doc: use consolidation of local minima instead of a large neighborhood
    inputBinding:
      position: 15
      prefix: -consolidate-mode
  - id: only_maxima
    type:
      - 'null'
      - boolean
    doc: only find the maxima
    inputBinding:
      position: 16
      prefix: -only-maxima
  - id: only_minima
    type:
      - 'null'
      - boolean
    doc: only find the minima
    inputBinding:
      position: 17
      prefix: -only-minima
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
