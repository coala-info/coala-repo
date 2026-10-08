cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-change-mapping
label: connectome-workbench_wb_command_cifti-change-mapping
doc: "Take an existing cifti file and change one of the mappings. Exactly one of -series, -scalar, or -from-cifti must be specified. The direction can be either an integer starting from 1, or the strings 'ROW' or 'COLUMN'. The argument to -unit must be one of the following:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: data_cifti
    type: File
    doc: the cifti file to use the data from
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which direction on <data-cifti> to replace the mapping
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: the output cifti file
    inputBinding:
      position: 3
  - id: series_step
    type:
      - 'null'
      - float
    doc: increment between series points
    inputBinding:
      position: 4
      prefix: -series
  - id: series_start
    type:
      - 'null'
      - float
    doc: start value of the series (give with series_step)
    inputBinding:
      position: 5
  - id: unit
    type:
      - 'null'
      - string
    doc: 'select unit for series (default SECOND): unit identifier (use with -series)'
    inputBinding:
      position: 6
      prefix: -unit
  - id: scalar
    type:
      - 'null'
      - boolean
    doc: set the mapping to scalar
    inputBinding:
      position: 7
      prefix: -scalar
  - id: name_file
    type:
      - 'null'
      - File
    doc: 'specify names for the maps: text file containing map names, one per line (use with -scalar)'
    inputBinding:
      position: 8
      prefix: -name-file
  - id: from_cifti_template_cifti
    type:
      - 'null'
      - File
    doc: a cifti file containing the desired mapping
    inputBinding:
      position: 9
      prefix: -from-cifti
  - id: from_cifti_direction
    type:
      - 'null'
      - string
    doc: which direction to copy the mapping from (give with from_cifti_template_cifti)
    inputBinding:
      position: 10
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
