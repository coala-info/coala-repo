cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-dilate
label: connectome-workbench_wb_command_cifti-dilate
doc: "For all data values designated as bad, if they neighbor a good value or are within the specified distance of a good value in the same kind of model, replace the value with a distance weighted average of nearby good values, otherwise set the value to zero. If -nearest is specified, it will use the value from the closest good value within range instead of a weighted average. When the input file contains label data, nearest dilation is used on the surface, and weighted popularity is used in the volume. The -*-corrected-areas options are intended for dilating on group average surfaces, but it is only an approximate correction for the reduction of structure in a group average surface. If -bad-brainordinate-roi is specified, all values, including those with value zero, are good, except for locations with a positive value in the ROI. If it is not specified, only values equal to zero are bad.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the input cifti file
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which dimension to dilate along, ROW or COLUMN
    inputBinding:
      position: 2
  - id: surface_distance
    type: float
    doc: the distance to dilate on surfaces, in mm
    inputBinding:
      position: 3
  - id: volume_distance
    type: float
    doc: the distance to dilate in the volume, in mm
    inputBinding:
      position: 4
  - id: cifti_out
    type: string
    doc: the output cifti file
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
  - id: left_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the left surface: the corrected vertex areas, as a metric (use with -left-surface)'
    inputBinding:
      position: 7
      prefix: -left-corrected-areas
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 8
      prefix: -right-surface
  - id: right_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the right surface: the corrected vertex areas, as a metric (use with -right-surface)'
    inputBinding:
      position: 9
      prefix: -right-corrected-areas
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 10
      prefix: -cerebellum-surface
  - id: cerebellum_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the cerebellum surface: the corrected vertex areas, as a metric (use with -cerebellum-surface)'
    inputBinding:
      position: 11
      prefix: -cerebellum-corrected-areas
  - id: bad_brainordinate_roi
    type:
      - 'null'
      - File
    doc: 'specify an roi of brainordinates to overwrite, rather than zeros: cifti dscalar or dtseries file, positive values denote brainordinates to have their values replaced'
    inputBinding:
      position: 12
      prefix: -bad-brainordinate-roi
  - id: nearest
    type:
      - 'null'
      - boolean
    doc: use nearest value
    inputBinding:
      position: 13
      prefix: -nearest
  - id: merged_volume
    type:
      - 'null'
      - boolean
    doc: treat volume components as if they were a single component
    inputBinding:
      position: 14
      prefix: -merged-volume
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
