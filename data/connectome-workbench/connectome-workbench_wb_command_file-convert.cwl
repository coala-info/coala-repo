cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-file-convert'
label: connectome-workbench_wb_command_file-convert
doc: "Change version of file format (border, nifti or cifti). You may only specify one top-level option.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: border_in
    type:
      - 'null'
      - File
    doc: '-border-version-convert: the input border file'
    inputBinding:
      position: 1
      prefix: '-border-version-convert'
  - id: border_out_version
    type:
      - 'null'
      - int
    doc: "with border_in: the format version to write as, 1 or 3 (2 doesn't exist)"
    inputBinding:
      position: 2
  - id: border_out
    type:
      - 'null'
      - string
    doc: 'with border_in: output - the output border file'
    inputBinding:
      position: 3
  - id: border_surface
    type:
      - 'null'
      - File
    doc: 'with border_in: must be specified if the input is version 1; surface file for structure and number of vertices'
    inputBinding:
      position: 4
      prefix: '-surface'
  - id: nifti_in
    type:
      - 'null'
      - File
    doc: '-nifti-version-convert: the input nifti file'
    inputBinding:
      position: 5
      prefix: '-nifti-version-convert'
  - id: nifti_version
    type:
      - 'null'
      - int
    doc: 'with nifti_in: the nifti version to write as'
    inputBinding:
      position: 6
  - id: nifti_out
    type:
      - 'null'
      - string
    doc: 'with nifti_in: output - the output nifti file'
    inputBinding:
      position: 7
  - id: cifti_in
    type:
      - 'null'
      - File
    doc: '-cifti-version-convert: the input cifti file'
    inputBinding:
      position: 8
      prefix: '-cifti-version-convert'
  - id: cifti_version
    type:
      - 'null'
      - string
    doc: 'with cifti_in: the cifti version to write as'
    inputBinding:
      position: 9
  - id: cifti_out
    type:
      - 'null'
      - string
    doc: 'with cifti_in: output - the output cifti file'
    inputBinding:
      position: 10
outputs:
  - id: border_converted
    type:
      - 'null'
      - File
    doc: the output border file
    outputBinding:
      glob: $(inputs.border_out)
  - id: nifti_converted
    type:
      - 'null'
      - File
    doc: the output nifti file
    outputBinding:
      glob: $(inputs.nifti_out)
  - id: cifti_converted
    type:
      - 'null'
      - File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
