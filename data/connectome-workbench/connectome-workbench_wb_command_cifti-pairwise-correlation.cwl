cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-pairwise-correlation
label: connectome-workbench_wb_command_cifti-pairwise-correlation
doc: "For each row in <cifti-a>, correlate it with the same row in <cifti-b>, and put the result in the same row of <cifti-out>, which has only one column.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_a
    type: File
    doc: first input cifti file
    inputBinding:
      position: 1
  - id: cifti_b
    type: File
    doc: second input cifti file
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: output cifti file
    inputBinding:
      position: 3
  - id: fisher_z
    type:
      - 'null'
      - boolean
    doc: apply fisher small z transform (ie, artanh) to correlation
    inputBinding:
      position: 4
      prefix: -fisher-z
  - id: override_mapping_check
    type:
      - 'null'
      - boolean
    doc: don't check the mappings for compatibility, only check length
    inputBinding:
      position: 5
      prefix: -override-mapping-check
outputs:
  - id: cifti_out_file
    type: File
    doc: output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
