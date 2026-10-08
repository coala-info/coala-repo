cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-correlation
label: connectome-workbench_wb_command_cifti-correlation
doc: "For each row (or each row inside an roi if -roi-override is specified), correlate to all other rows. The -cifti-roi suboption to -roi-override may not be specified with any other -*-roi suboption, but you may specify the other -*-roi suboptions together. When using the -fisher-z option, the output is NOT a Z-score, it is artanh(r), to do further math on this output, consider using -cifti-math. Restricting the memory usage will make it calculate the output in chunks, and if the input file size is more than 70% of the memory limit, it will also read through the input file as rows are required, resulting in several passes through the input file (once per chunk). Memory limit does not need to be an integer, you may also specify 0 to calculate a single output row at a time (this may be very slow).\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: input cifti file
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 2
  - id: roi_override
    type:
      - 'null'
      - boolean
    doc: perform correlation from a subset of rows to all rows
    inputBinding:
      position: 3
      prefix: -roi-override
  - id: left_roi
    type:
      - 'null'
      - File
    doc: 'use an roi for left hempsphere: the left roi as a metric file (use with -roi-override)'
    inputBinding:
      position: 4
      prefix: -left-roi
  - id: right_roi
    type:
      - 'null'
      - File
    doc: 'use an roi for right hempsphere: the right roi as a metric file (use with -roi-override)'
    inputBinding:
      position: 5
      prefix: -right-roi
  - id: cerebellum_roi
    type:
      - 'null'
      - File
    doc: 'use an roi for cerebellum: the cerebellum roi as a metric file (use with -roi-override)'
    inputBinding:
      position: 6
      prefix: -cerebellum-roi
  - id: vol_roi
    type:
      - 'null'
      - File
    doc: 'use an roi for volume: the volume roi file (use with -roi-override)'
    inputBinding:
      position: 7
      prefix: -vol-roi
  - id: cifti_roi
    type:
      - 'null'
      - File
    doc: 'use a cifti file for combined rois: the cifti roi file (use with -roi-override)'
    inputBinding:
      position: 8
      prefix: -cifti-roi
  - id: weights
    type:
      - 'null'
      - File
    doc: 'specify column weights: text file containing one weight per column'
    inputBinding:
      position: 9
      prefix: -weights
  - id: fisher_z
    type:
      - 'null'
      - boolean
    doc: apply fisher small z transform (ie, artanh) to correlation
    inputBinding:
      position: 10
      prefix: -fisher-z
  - id: no_demean
    type:
      - 'null'
      - boolean
    doc: instead of correlation, do dot product of rows, then normalize by diagonal
    inputBinding:
      position: 11
      prefix: -no-demean
  - id: covariance
    type:
      - 'null'
      - boolean
    doc: compute covariance instead of correlation
    inputBinding:
      position: 12
      prefix: -covariance
  - id: mem_limit
    type:
      - 'null'
      - float
    doc: 'restrict memory usage: memory limit in gigabytes'
    inputBinding:
      position: 13
      prefix: -mem-limit
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
