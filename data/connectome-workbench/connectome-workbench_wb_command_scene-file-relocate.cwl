cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -scene-file-relocate
label: connectome-workbench_wb_command_scene-file-relocate
doc: 'Scene files contain internal relative paths, such that moving or copying a scene
  file will cause it to lose track of the files it refers to. This command makes a
  modified copy of the scene file, changing the relative paths to refer to the new
  relative locations of the files.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_scene)
inputs:
  - id: input_scene
    type: File
    doc: the scene file to use
    inputBinding:
      position: 1
  - id: output_scene
    type: string
    doc: output - the new scene file to create
    inputBinding:
      position: 2
outputs:
  - id: output_scene_file
    type: File
    doc: the new scene file to create
    outputBinding:
      glob: $(inputs.output_scene)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
