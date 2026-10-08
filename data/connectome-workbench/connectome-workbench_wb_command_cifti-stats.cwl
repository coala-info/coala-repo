cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-stats'
label: connectome-workbench_wb_command_cifti-stats
doc: "Statistics along cifti columns. For each column of the input, a row of text is printed, resulting from the specified reduction or percentile operation. Use -column to only give output for a single data column. Exactly one of -reduce or -percentile must be specified.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: reduce
    type:
      - 'null'
      - string
    doc: 'use a reduction operation: MAX, MIN, INDEXMAX, INDEXMIN, SUM, PRODUCT, MEAN, STDEV, SAMPSTDEV, VARIANCE, TSNR, COV, MEDIAN, MODE, COUNT_NONZERO'
    inputBinding:
      position: 2
      prefix: '-reduce'
  - id: percentile
    type:
      - 'null'
      - float
    doc: give the value at a percentile
    inputBinding:
      position: 2
      prefix: '-percentile'
  - id: column
    type:
      - 'null'
      - int
    doc: only display output for one column (index starting from 1)
    inputBinding:
      position: 2
      prefix: '-column'
  - id: roi
    type:
      - 'null'
      - File
    doc: only consider data inside an roi, given as a cifti file
    inputBinding:
      position: 3
      prefix: '-roi'
  - id: match_maps
    type:
      - 'null'
      - boolean
    doc: 'with roi: each column of input uses the corresponding column from the roi file'
    inputBinding:
      position: 4
      prefix: '-match-maps'
  - id: show_map_name
    type:
      - 'null'
      - boolean
    doc: print column index and name before each output
    inputBinding:
      position: 5
      prefix: '-show-map-name'
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: cifti-stats.txt
outputs:
  - id: stats
    type: File
    doc: one row of numbers per column
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
