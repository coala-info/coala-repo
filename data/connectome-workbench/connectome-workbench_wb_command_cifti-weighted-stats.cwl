cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-weighted-stats'
label: connectome-workbench_wb_command_cifti-weighted-stats
doc: "Weighted statistics along cifti columns. If the mapping along column is brain models, the operation is done on each surface and across all voxels, and the results are printed separately. Exactly one of -spatial-weights or -cifti-weights must be specified. Exactly one of -mean, -stdev, -percentile or -sum must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: spatial_weights
    type:
      - 'null'
      - boolean
    doc: use vertex area and voxel volume as weights
    inputBinding:
      position: 10
      prefix: '-spatial-weights'
  - id: left_area_surf
    type:
      - 'null'
      - File
    doc: 'with spatial_weights: a surface for left vertex areas'
    inputBinding:
      position: 11
      prefix: '-left-area-surf'
  - id: right_area_surf
    type:
      - 'null'
      - File
    doc: 'with spatial_weights: a surface for right vertex areas'
    inputBinding:
      position: 12
      prefix: '-right-area-surf'
  - id: cerebellum_area_surf
    type:
      - 'null'
      - File
    doc: 'with spatial_weights: a surface for cerebellum vertex areas'
    inputBinding:
      position: 13
      prefix: '-cerebellum-area-surf'
  - id: left_area_metric
    type:
      - 'null'
      - File
    doc: 'with spatial_weights: a metric file containing left vertex areas'
    inputBinding:
      position: 14
      prefix: '-left-area-metric'
  - id: right_area_metric
    type:
      - 'null'
      - File
    doc: 'with spatial_weights: a metric file containing right vertex areas'
    inputBinding:
      position: 15
      prefix: '-right-area-metric'
  - id: cerebellum_area_metric
    type:
      - 'null'
      - File
    doc: 'with spatial_weights: a metric file containing cerebellum vertex areas'
    inputBinding:
      position: 16
      prefix: '-cerebellum-area-metric'
  - id: cifti_weights
    type:
      - 'null'
      - File
    doc: use a cifti file containing weights
    inputBinding:
      position: 17
      prefix: '-cifti-weights'
  - id: column
    type:
      - 'null'
      - int
    doc: only display output for one column (1-based)
    inputBinding:
      position: 18
      prefix: '-column'
  - id: roi
    type:
      - 'null'
      - File
    doc: only consider data inside an roi, given as a cifti file
    inputBinding:
      position: 19
      prefix: '-roi'
  - id: match_maps
    type:
      - 'null'
      - boolean
    doc: 'with roi: each column of input uses the corresponding column from the roi file'
    inputBinding:
      position: 20
      prefix: '-match-maps'
  - id: mean
    type:
      - 'null'
      - boolean
    doc: compute weighted mean
    inputBinding:
      position: 21
      prefix: '-mean'
  - id: stdev
    type:
      - 'null'
      - boolean
    doc: compute weighted standard deviation
    inputBinding:
      position: 22
      prefix: '-stdev'
  - id: sample
    type:
      - 'null'
      - boolean
    doc: 'with stdev: estimate population stdev from the sample'
    inputBinding:
      position: 23
      prefix: '-sample'
  - id: percentile
    type:
      - 'null'
      - float
    doc: compute weighted percentile
    inputBinding:
      position: 24
      prefix: '-percentile'
  - id: sum
    type:
      - 'null'
      - boolean
    doc: compute weighted sum
    inputBinding:
      position: 25
      prefix: '-sum'
  - id: show_map_name
    type:
      - 'null'
      - boolean
    doc: print map index and name before each output
    inputBinding:
      position: 26
      prefix: '-show-map-name'
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: cifti-weighted-stats.txt
outputs:
  - id: stats
    type: File
    doc: the printed statistics
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
