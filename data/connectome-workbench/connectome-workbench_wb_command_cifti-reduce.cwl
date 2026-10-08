cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-reduce
label: connectome-workbench_wb_command_cifti-reduce
doc: "For the specified direction (default ROW), perform a reduction operation along that direction. The direction can be either an integer starting from 1, or the strings 'ROW' or 'COLUMN'. The reduction operators are as follows: MAX: the maximum value MIN: the minimum value INDEXMAX: the 1-based index of the maximum value INDEXMIN: the 1-based index of the minimum value SUM: add all values PRODUCT: multiply all values MEAN: the mean of the data STDEV: the standard deviation (N denominator) SAMPSTDEV: the sample standard deviation (N-1 denominator) VARIANCE: the variance of the data TSNR: mean divided by sample standard deviation (N-1 denominator) COV: sample standard deviation (N-1 denominator) divided by mean MEDIAN: the median of the data MODE: the mode of the data COUNT_NONZERO: the number of nonzero elements in the data\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the cifti file to reduce
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: the reduction operator to use
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 3
  - id: direction
    type:
      - 'null'
      - string
    doc: 'specify what direction to reduce along: the direction (default ROW)'
    inputBinding:
      position: 4
      prefix: -direction
  - id: exclude_outliers_sigma_below
    type:
      - 'null'
      - float
    doc: number of standard deviations below the mean to include
    inputBinding:
      position: 5
      prefix: -exclude-outliers
  - id: exclude_outliers_sigma_above
    type:
      - 'null'
      - float
    doc: number of standard deviations above the mean to include (give with exclude_outliers_sigma_below)
    inputBinding:
      position: 6
  - id: only_numeric
    type:
      - 'null'
      - boolean
    doc: exclude non-numeric values
    inputBinding:
      position: 7
      prefix: -only-numeric
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
