cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - list_libraries
label: nebulizer_list_libraries
doc: "List data libraries and contents.\n\n  Prints details of the data library and
  folders specified by PATH, in\n  GALAXY instance.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_instance
    type: string
    doc: GALAXY instance
    inputBinding:
      position: 1
  - id: path
    type:
      - 'null'
      - string
    doc: PATH should be of the form 'data_library[/folder[/subfolder[...]]]' 
      (data library and folders)
    inputBinding:
      position: 2
  - id: long_listing
    type:
      - 'null'
      - boolean
    doc: "use a long listing format that includes descriptions, file sizes,\ndbkeys
      and paths)"
    inputBinding:
      position: 103
      prefix: -l
  - id: show_id
    type:
      - 'null'
      - boolean
    doc: "include internal Galaxy IDs for data libraries, folders and\ndatasets."
    inputBinding:
      position: 103
      prefix: --show_id
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_list_libraries.out
