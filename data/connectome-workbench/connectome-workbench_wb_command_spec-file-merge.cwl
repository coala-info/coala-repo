cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -spec-file-merge
label: connectome-workbench_wb_command_spec-file-merge
doc: 'The output spec file contains every file that is in either of the input spec
  files.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.spec_1)
      - $(inputs.spec_2)
inputs:
  - id: spec_1
    type: File
    doc: first spec file to merge
    inputBinding:
      position: 1
  - id: spec_2
    type: File
    doc: second spec file to merge
    inputBinding:
      position: 2
  - id: out_spec
    type: string
    doc: output - output spec file
    inputBinding:
      position: 3
outputs:
  - id: out_spec_file
    type: File
    doc: output spec file
    outputBinding:
      glob: $(inputs.out_spec)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
