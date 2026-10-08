cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -set-structure
label: connectome-workbench_wb_command_set-structure
doc: 'The existing file is modified and rewritten to the same filename. Valid values
  for the structure name are:


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.data_file)
        writable: true
inputs:
  - id: data_file
    type: File
    doc: the file to set the structure of
    inputBinding:
      position: 1
  - id: structure
    type: string
    doc: the structure to set the file to
    inputBinding:
      position: 2
  - id: surface_type
    type:
      - 'null'
      - string
    doc: set the type of a surface (only used if file is a surface file)
    inputBinding:
      position: 3
      prefix: -surface-type
  - id: surface_secondary_type
    type:
      - 'null'
      - string
    doc: set the secondary type of a surface (only used if file is a surface file)
    inputBinding:
      position: 3
      prefix: -surface-secondary-type
outputs:
  - id: data_file_modified
    type: File
    doc: the input file, modified in place
    outputBinding:
      glob: $(inputs.data_file.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
