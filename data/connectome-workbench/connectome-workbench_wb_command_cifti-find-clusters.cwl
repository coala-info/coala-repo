cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-find-clusters
label: connectome-workbench_wb_command_cifti-find-clusters
doc: "Outputs a cifti file with nonzero integers for all brainordinates within a large enough cluster, and zeros elsewhere. The integers denote cluster membership (by default, first cluster found will use value 1, second cluster 2, etc). The input cifti file must have a brain models mapping on the chosen dimension, columns for .dtseries, and either for .dconn. The ROI should have a brain models mapping along columns, exactly matching the mapping of the chosen direction in the input file. Data outside the ROI is ignored.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: surface_value_threshold
    type: float
    doc: threshold for surface data values
    inputBinding:
      position: 2
  - id: surface_minimum_area
    type: float
    doc: threshold for surface cluster area, in mm^2
    inputBinding:
      position: 3
  - id: volume_value_threshold
    type: float
    doc: threshold for volume data values
    inputBinding:
      position: 4
  - id: volume_minimum_size
    type: float
    doc: threshold for volume cluster size, in mm^3
    inputBinding:
      position: 5
  - id: direction
    type: string
    doc: which dimension to use for spatial information, ROW or COLUMN
    inputBinding:
      position: 6
  - id: cifti_out
    type: string
    doc: the output cifti
    inputBinding:
      position: 7
  - id: less_than
    type:
      - 'null'
      - boolean
    doc: find values less than <value-threshold>, rather than greater
    inputBinding:
      position: 8
      prefix: -less-than
  - id: left_surface
    type:
      - 'null'
      - File
    doc: 'specify the left surface to use: the left surface file'
    inputBinding:
      position: 9
      prefix: -left-surface
  - id: corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the surface: the corrected vertex areas, as a metric (use with -left-surface)'
    inputBinding:
      position: 10
      prefix: -corrected-areas
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 11
      prefix: -right-surface
  - id: right_surface_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the surface: the corrected vertex areas, as a metric (use with -right-surface)'
    inputBinding:
      position: 12
      prefix: -corrected-areas
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 13
      prefix: -cerebellum-surface
  - id: cerebellum_surface_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the surface: the corrected vertex areas, as a metric (use with -cerebellum-surface)'
    inputBinding:
      position: 14
      prefix: -corrected-areas
  - id: cifti_roi
    type:
      - 'null'
      - File
    doc: 'search only within regions of interest: the regions to search within, as a cifti file'
    inputBinding:
      position: 15
      prefix: -cifti-roi
  - id: merged_volume
    type:
      - 'null'
      - boolean
    doc: treat volume components as if they were a single component
    inputBinding:
      position: 16
      prefix: -merged-volume
  - id: size_ratio_surface_ratio
    type:
      - 'null'
      - float
    doc: fraction of the structure's largest cluster area
    inputBinding:
      position: 17
      prefix: -size-ratio
  - id: size_ratio_volume_ratio
    type:
      - 'null'
      - float
    doc: fraction of the structure's largest cluster volume (give with size_ratio_surface_ratio)
    inputBinding:
      position: 18
  - id: distance_surface_distance
    type:
      - 'null'
      - float
    doc: how far from the largest cluster a cluster can be, edge to edge, in mm
    inputBinding:
      position: 19
      prefix: -distance
  - id: distance_volume_distance
    type:
      - 'null'
      - float
    doc: how far from the largest cluster a cluster can be, edge to edge, in mm (give with distance_surface_distance)
    inputBinding:
      position: 20
  - id: start
    type:
      - 'null'
      - int
    doc: 'start labeling clusters from a value other than 1: the value to give the first cluster found'
    inputBinding:
      position: 21
      prefix: -start
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
