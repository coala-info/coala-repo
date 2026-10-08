cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -zip-scene-file
label: connectome-workbench_wb_command_zip-scene-file
doc: "If zip-file already exists, it will be overwritten. If -base-dir is not specified, the base directory will be automatically set to the lowest level directory containing all files. The scene file must contain only relative paths, and no data files may be outside the base directory.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.scene_file)
      - $(inputs.data_files)
      - $(inputs.data_dirs)
inputs:
  - id: scene_file
    type: File
    doc: "the scene file to make the zip file from"
    inputBinding:
      position: 1
  - id: extract_folder
    type: string
    doc: "the name of the folder created when the zip file is unzipped"
    inputBinding:
      position: 2
  - id: zip_file
    type: string
    doc: "output - the zip file that will be created"
    inputBinding:
      position: 3
  - id: base_dir
    type:
      - 'null'
      - string
    doc: "specify a directory that all data files are somewhere within, this will become the root of the zipfile's directory structure: the directory, as a path relative to the working directory where the inputs are staged"
    inputBinding:
      position: 4
      prefix: -base-dir
  - id: data_files
    type:
      type: array
      items: File
    doc: "data files the scene references, staged next to the scene file (the scene or spec file must name them by relative path in the same folder)"
    default: []
  - id: data_dirs
    type:
      type: array
      items: Directory
    doc: "folders of data files the file references, staged next to it with their own names (for relative paths such as SUBJECT/MNINonLinear/x.surf.gii)"
    default: []
outputs:
  - id: output_zip
    type: File
    doc: "the zip file that will be created"
    outputBinding:
      glob: $(inputs.zip_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
