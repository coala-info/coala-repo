cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - create_library_folder
label: nebulizer_create_library_folder
doc: "Create new folder in a data library.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_path
    type: string
    doc: The path to the new folder or folder tree within an existing data 
      library in GALAXY. Should be of the form 
      'data_library[/folder[/subfolder[...]]]'.
    inputBinding:
      position: 1
  - id: description
    type:
      - 'null'
      - string
    doc: description of the new folder
    inputBinding:
      position: 102
      prefix: --description
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_create_library_folder.out
