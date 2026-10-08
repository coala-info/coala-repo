cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-parcellate
label: connectome-workbench_wb_command_cifti-parcellate
doc: "Each non-empty label (other than the unlabeled key) in the cifti label file will be treated as a parcel, and all rows or columns within the parcel are averaged together to form the output row or column. If -include-empty is specified, empty labels will be treated as parcels with no elements, and filled with a constant value. The direction can be either an integer starting from 1, or the strings 'ROW' or 'COLUMN'. For dtseries or dscalar, use COLUMN. If you are parcellating a dconn in both directions, parcellating by ROW first will use much less memory. The parameter to the -method option must be one of the following: MAX: the maximum value MIN: the minimum value INDEXMAX: the 1-based index of the maximum value INDEXMIN: the 1-based index of the minimum value SUM: add all values PRODUCT: multiply all values MEAN: the mean of the data STDEV: the standard deviation (N denominator) SAMPSTDEV: the sample standard deviation (N-1 denominator) VARIANCE: the variance of the data TSNR: mean divided by sample standard deviation (N-1 denominator) COV: sample standard deviation (N-1 denominator) divided by mean MEDIAN: the median of the data MODE: the mode of the data COUNT_NONZERO: the number of nonzero elements in the data The -*-weights options are mutually exclusive and may only be used with MEAN, SUM, STDEV, SAMPSTDEV, VARIANCE, MEDIAN, or MODE.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the cifti file to parcellate
    inputBinding:
      position: 1
  - id: cifti_label
    type: File
    doc: a cifti label file to use for the parcellation
    inputBinding:
      position: 2
  - id: direction
    type: string
    doc: which mapping to parcellate (integer, ROW, or COLUMN)
    inputBinding:
      position: 3
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 4
  - id: spatial_weights
    type:
      - 'null'
      - boolean
    doc: use voxel volume and either vertex areas or metric files as weights
    inputBinding:
      position: 5
      prefix: -spatial-weights
  - id: left_area_surf
    type:
      - 'null'
      - File
    doc: 'use a surface for left vertex areas: the left surface to use, areas are in mm^2 (use with -spatial-weights)'
    inputBinding:
      position: 6
      prefix: -left-area-surf
  - id: right_area_surf
    type:
      - 'null'
      - File
    doc: 'use a surface for right vertex areas: the right surface to use, areas are in mm^2 (use with -spatial-weights)'
    inputBinding:
      position: 7
      prefix: -right-area-surf
  - id: cerebellum_area_surf
    type:
      - 'null'
      - File
    doc: 'use a surface for cerebellum vertex areas: the cerebellum surface to use, areas are in mm^2 (use with -spatial-weights)'
    inputBinding:
      position: 8
      prefix: -cerebellum-area-surf
  - id: left_area_metric
    type:
      - 'null'
      - File
    doc: 'use a metric file for left vertex weights: metric file containing left vertex weights (use with -spatial-weights)'
    inputBinding:
      position: 9
      prefix: -left-area-metric
  - id: right_area_metric
    type:
      - 'null'
      - File
    doc: 'use a metric file for right vertex weights: metric file containing right vertex weights (use with -spatial-weights)'
    inputBinding:
      position: 10
      prefix: -right-area-metric
  - id: cerebellum_area_metric
    type:
      - 'null'
      - File
    doc: 'use a metric file for cerebellum vertex weights: metric file containing cerebellum vertex weights (use with -spatial-weights)'
    inputBinding:
      position: 11
      prefix: -cerebellum-area-metric
  - id: cifti_weights
    type:
      - 'null'
      - File
    doc: 'use a cifti file containing weights: the weights to use, as a cifti file'
    inputBinding:
      position: 12
      prefix: -cifti-weights
  - id: method
    type:
      - 'null'
      - string
    doc: 'specify method of parcellation (default MEAN, or MODE if label data): the method to use to assign parcel values from the values of member brainordinates'
    inputBinding:
      position: 13
      prefix: -method
  - id: exclude_outliers_sigma_below
    type:
      - 'null'
      - float
    doc: number of standard deviations below the mean to include
    inputBinding:
      position: 14
      prefix: -exclude-outliers
  - id: exclude_outliers_sigma_above
    type:
      - 'null'
      - float
    doc: number of standard deviations above the mean to include (give with exclude_outliers_sigma_below)
    inputBinding:
      position: 15
  - id: only_numeric
    type:
      - 'null'
      - boolean
    doc: exclude non-numeric values
    inputBinding:
      position: 16
      prefix: -only-numeric
  - id: include_empty
    type:
      - 'null'
      - boolean
    doc: create parcels for labels that have no vertices or voxels
    inputBinding:
      position: 17
      prefix: -include-empty
  - id: fill_value
    type:
      - 'null'
      - float
    doc: 'specify value to use in empty parcels (default 0): the value to fill empty parcels with (use with -include-empty)'
    inputBinding:
      position: 18
      prefix: -fill-value
  - id: nonempty_mask_out
    type:
      - 'null'
      - string
    doc: 'output a matching pscalar file that has 0s in empty parcels, and 1s elsewhere: the output mask file (use with -include-empty)'
    inputBinding:
      position: 19
      prefix: -nonempty-mask-out
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
  - id: nonempty_mask_out_file
    type:
      - 'null'
      - File
    doc: the output mask file
    outputBinding:
      glob: $(inputs.nonempty_mask_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
