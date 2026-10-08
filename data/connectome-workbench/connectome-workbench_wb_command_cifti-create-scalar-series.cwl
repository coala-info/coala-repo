cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-create-scalar-series
label: connectome-workbench_wb_command_cifti-create-scalar-series
doc: "Convert a text file containing series of equal length into a cifti file. The text file should have lines made up of numbers separated by whitespace, with no extra newlines between lines. The <unit> argument must be one of the following:\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: input
    type: File
    doc: input file
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 2
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: use if the rows of the text file are along the scalar dimension
    inputBinding:
      position: 3
      prefix: -transpose
  - id: name_file
    type:
      - 'null'
      - File
    doc: 'use a text file to set names on scalar dimension: text file containing names, one per line'
    inputBinding:
      position: 4
      prefix: -name-file
  - id: series_unit
    type:
      - 'null'
      - string
    doc: the unit to use
    inputBinding:
      position: 5
      prefix: -series
  - id: series_start
    type:
      - 'null'
      - float
    doc: the value at the first series point (give with series_unit)
    inputBinding:
      position: 6
  - id: series_step
    type:
      - 'null'
      - float
    doc: the interval between series points (give with series_unit)
    inputBinding:
      position: 7
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
