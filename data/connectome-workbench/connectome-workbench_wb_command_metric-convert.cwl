cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metric-convert'
label: connectome-workbench_wb_command_metric-convert
doc: "Convert a metric file to fake nifti and back, so that gifti-unaware programs can operate on the data. You must specify exactly one of the options.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: to_nifti_metric
    type:
      - 'null'
      - File
    doc: '-to-nifti: the metric to convert to nifti'
    inputBinding:
      position: 1
      prefix: '-to-nifti'
  - id: to_nifti_out
    type:
      - 'null'
      - string
    doc: 'with to_nifti_metric: output - the output nifti file'
    inputBinding:
      position: 2
  - id: from_nifti_in
    type:
      - 'null'
      - File
    doc: '-from-nifti: the nifti file to convert to metric'
    inputBinding:
      position: 3
      prefix: '-from-nifti'
  - id: from_nifti_surface
    type:
      - 'null'
      - File
    doc: 'with from_nifti_in: surface file to use number of vertices and structure from'
    inputBinding:
      position: 4
  - id: from_nifti_metric_out
    type:
      - 'null'
      - string
    doc: 'with from_nifti_in: output - the output metric file'
    inputBinding:
      position: 5
outputs:
  - id: nifti_out
    type:
      - 'null'
      - File
    doc: the output nifti file
    outputBinding:
      glob: $(inputs.to_nifti_out)
  - id: metric_out
    type:
      - 'null'
      - File
    doc: the output metric file
    outputBinding:
      glob: $(inputs.from_nifti_metric_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
