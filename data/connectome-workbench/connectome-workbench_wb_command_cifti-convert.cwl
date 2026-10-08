cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-convert
label: connectome-workbench_wb_command_cifti-convert
doc: "This command is used to convert a full CIFTI matrix to/from formats that can be used by programs that don't understand CIFTI. You must specify exactly one of -to-gifti-ext, -from-gifti-ext, -to-nifti, -from-nifti, -to-text, or -from-text. If you want to write an existing CIFTI file with a different CIFTI version, see -file-convert, and its -cifti-version-convert option. If you want part of the CIFTI file as a metric, label, or volume file, see -cifti-separate. If you want to create a CIFTI file from metric and/or volume files, see the -cifti-create-* commands. If you want to import a matrix that is restricted to an ROI, first create a template CIFTI file matching that ROI using a -cifti-create-* command. After importing to CIFTI, you can then expand the file into a standard brainordinates space with -cifti-create-dense-from-template. If you want to export only part of a CIFTI file, first create an roi-restricted CIFTI file with -cifti-restrict-dense-mapping. The -transpose option to -from-gifti-ext is needed if the replacement binary file is in column-major order. The -unit options accept these values:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: to_gifti_ext_cifti_in
    type:
      - 'null'
      - File
    doc: the input cifti file
    inputBinding:
      position: 1
      prefix: -to-gifti-ext
  - id: to_gifti_ext_gifti_out
    type:
      - 'null'
      - string
    doc: the output gifti file (give with to_gifti_ext_cifti_in)
    inputBinding:
      position: 2
  - id: from_gifti_ext_gifti_in
    type:
      - 'null'
      - File
    doc: the input gifti file
    inputBinding:
      position: 3
      prefix: -from-gifti-ext
  - id: from_gifti_ext_cifti_out
    type:
      - 'null'
      - string
    doc: the output cifti file (give with from_gifti_ext_gifti_in)
    inputBinding:
      position: 4
  - id: reset_timepoints_timestep
    type:
      - 'null'
      - float
    doc: the desired time between frames (use with -from-gifti-ext)
    inputBinding:
      position: 5
      prefix: -reset-timepoints
  - id: reset_timepoints_timestart
    type:
      - 'null'
      - float
    doc: the desired time offset of the initial frame (give with reset_timepoints_timestep) (use with -from-gifti-ext)
    inputBinding:
      position: 6
  - id: unit
    type:
      - 'null'
      - string
    doc: 'use a unit other than time: unit identifier (default SECOND) (use with -reset-timepoints)'
    inputBinding:
      position: 7
      prefix: -unit
  - id: reset_scalars
    type:
      - 'null'
      - boolean
    doc: reset mapping along rows to scalars, taking length from the gifti file (use with -from-gifti-ext)
    inputBinding:
      position: 8
      prefix: -reset-scalars
  - id: replace_binary
    type:
      - 'null'
      - File
    doc: 'replace data with a binary file: the binary file that contains replacement data (use with -from-gifti-ext)'
    inputBinding:
      position: 9
      prefix: -replace-binary
  - id: flip_endian
    type:
      - 'null'
      - boolean
    doc: byteswap the binary file (use with -replace-binary)
    inputBinding:
      position: 10
      prefix: -flip-endian
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: transpose the binary file (use with -replace-binary)
    inputBinding:
      position: 11
      prefix: -transpose
  - id: to_nifti_cifti_in
    type:
      - 'null'
      - File
    doc: the input cifti file
    inputBinding:
      position: 12
      prefix: -to-nifti
  - id: to_nifti_nifti_out
    type:
      - 'null'
      - string
    doc: the output nifti file (give with to_nifti_cifti_in)
    inputBinding:
      position: 13
  - id: smaller_file
    type:
      - 'null'
      - boolean
    doc: use better-fitting dimension lengths (use with -to-nifti)
    inputBinding:
      position: 14
      prefix: -smaller-file
  - id: smaller_dims
    type:
      - 'null'
      - boolean
    doc: minimize the largest dimension, for tools that don't like large indices (use with -to-nifti)
    inputBinding:
      position: 15
      prefix: -smaller-dims
  - id: from_nifti_nifti_in
    type:
      - 'null'
      - File
    doc: the input nifti file
    inputBinding:
      position: 16
      prefix: -from-nifti
  - id: from_nifti_cifti_template
    type:
      - 'null'
      - File
    doc: a cifti file with the dimension(s) and mapping(s) that should be used (give with from_nifti_nifti_in)
    inputBinding:
      position: 17
  - id: from_nifti_cifti_out
    type:
      - 'null'
      - string
    doc: the output cifti file (give with from_nifti_nifti_in)
    inputBinding:
      position: 18
  - id: from_nifti_reset_timepoints_timestep
    type:
      - 'null'
      - float
    doc: the desired time between frames (use with -from-nifti)
    inputBinding:
      position: 19
      prefix: -reset-timepoints
  - id: from_nifti_reset_timepoints_timestart
    type:
      - 'null'
      - float
    doc: the desired time offset of the initial frame (give with from_nifti_reset_timepoints_timestep) (use with -from-nifti)
    inputBinding:
      position: 20
  - id: from_nifti_reset_timepoints_unit
    type:
      - 'null'
      - string
    doc: 'use a unit other than time: unit identifier (default SECOND) (use with -reset-timepoints)'
    inputBinding:
      position: 21
      prefix: -unit
  - id: from_nifti_reset_scalars
    type:
      - 'null'
      - boolean
    doc: reset mapping along rows to scalars, taking length from the nifti file (use with -from-nifti)
    inputBinding:
      position: 22
      prefix: -reset-scalars
  - id: to_text_cifti_in
    type:
      - 'null'
      - File
    doc: the input cifti file
    inputBinding:
      position: 23
      prefix: -to-text
  - id: to_text_text_out
    type:
      - 'null'
      - string
    doc: the output text file (give with to_text_cifti_in)
    inputBinding:
      position: 24
  - id: col_delim
    type:
      - 'null'
      - string
    doc: 'choose string to put between elements in a row: the string to use (default is a tab character) (use with -to-text)'
    inputBinding:
      position: 25
      prefix: -col-delim
  - id: from_text_text_in
    type:
      - 'null'
      - File
    doc: the input text file
    inputBinding:
      position: 26
      prefix: -from-text
  - id: from_text_cifti_template
    type:
      - 'null'
      - File
    doc: a cifti file with the dimension(s) and mapping(s) that should be used (give with from_text_text_in)
    inputBinding:
      position: 27
  - id: from_text_cifti_out
    type:
      - 'null'
      - string
    doc: the output cifti file (give with from_text_text_in)
    inputBinding:
      position: 28
  - id: from_text_col_delim
    type:
      - 'null'
      - string
    doc: 'specify string that is between elements in a row: the string to use (default is any whitespace) (use with -from-text)'
    inputBinding:
      position: 29
      prefix: -col-delim
  - id: from_text_reset_timepoints_timestep
    type:
      - 'null'
      - float
    doc: the desired time between frames (use with -from-text)
    inputBinding:
      position: 30
      prefix: -reset-timepoints
  - id: from_text_reset_timepoints_timestart
    type:
      - 'null'
      - float
    doc: the desired time offset of the initial frame (give with from_text_reset_timepoints_timestep) (use with -from-text)
    inputBinding:
      position: 31
  - id: from_text_reset_timepoints_unit
    type:
      - 'null'
      - string
    doc: 'use a unit other than time: unit identifier (default SECOND) (use with -reset-timepoints)'
    inputBinding:
      position: 32
      prefix: -unit
  - id: from_text_reset_scalars
    type:
      - 'null'
      - boolean
    doc: reset mapping along rows to scalars, taking length from the text file (use with -from-text)
    inputBinding:
      position: 33
      prefix: -reset-scalars
outputs:
  - id: to_gifti_ext_gifti_out_file
    type:
      - 'null'
      - File
    doc: the output gifti file
    outputBinding:
      glob: $(inputs.to_gifti_ext_gifti_out)
  - id: from_gifti_ext_cifti_out_file
    type:
      - 'null'
      - File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.from_gifti_ext_cifti_out)
  - id: to_nifti_nifti_out_file
    type:
      - 'null'
      - File
    doc: the output nifti file
    outputBinding:
      glob: $(inputs.to_nifti_nifti_out)
  - id: from_nifti_cifti_out_file
    type:
      - 'null'
      - File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.from_nifti_cifti_out)
  - id: to_text_text_out_file
    type:
      - 'null'
      - File
    doc: the output text file
    outputBinding:
      glob: $(inputs.to_text_text_out)
  - id: from_text_cifti_out_file
    type:
      - 'null'
      - File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.from_text_cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
