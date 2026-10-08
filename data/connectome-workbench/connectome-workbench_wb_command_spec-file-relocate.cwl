cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -spec-file-relocate
label: connectome-workbench_wb_command_spec-file-relocate
doc: 'Spec files contain internal relative paths, such that moving or copying a spec
  file will cause it to lose track of the files it refers to. This command makes a
  modified copy of the spec file, changing the relative paths to refer to the new
  relative locations of the files.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_spec)
inputs:
  - id: input_spec
    type: File
    doc: the spec file to use
    inputBinding:
      position: 1
  - id: output_spec
    type: string
    doc: output - the new spec file to create
    inputBinding:
      position: 2
outputs:
  - id: output_spec_file
    type: File
    doc: the new spec file to create
    outputBinding:
      glob: $(inputs.output_spec)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
