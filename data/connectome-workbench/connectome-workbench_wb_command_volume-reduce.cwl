cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-reduce
label: connectome-workbench_wb_command_volume-reduce
doc: "For each voxel, takes the data across subvolumes as a vector, and performs the specified reduction on it, putting the result into the single output volume at that voxel.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: volume_in
    type: File
    doc: "the volume file to reduce"
    inputBinding:
      position: 1
  - id: operation
    type: string
    doc: "the reduction operator to use: MAX, MIN, INDEXMAX, INDEXMIN, SUM, PRODUCT, MEAN, STDEV, SAMPSTDEV, VARIANCE, TSNR, COV, MEDIAN, MODE, COUNT_NONZERO"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 3
  - id: exclude_outliers_sigma_below
    type:
      - 'null'
      - float
    doc: "number of standard deviations below the mean to include (-exclude-outliers argument 1 of 2)"
    inputBinding:
      position: 4
      prefix: -exclude-outliers
  - id: exclude_outliers_sigma_above
    type:
      - 'null'
      - float
    doc: "number of standard deviations above the mean to include (-exclude-outliers argument 2 of 2)"
    inputBinding:
      position: 5
  - id: only_numeric
    type:
      - 'null'
      - boolean
    doc: "exclude non-numeric values"
    inputBinding:
      position: 6
      prefix: -only-numeric
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
