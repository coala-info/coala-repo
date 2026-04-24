cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - nebulizer
  - add_library_datasets
label: nebulizer_add_library_datasets
doc: "Add datasets to a data library.\n\nTool homepage: https://github.com/pjbriggs/nebulizer"
inputs:
  - id: galaxy_destination
    type: string
    doc: Galaxy destination path to a data library or library folder.
    inputBinding:
      position: 1
  - id: files
    type:
      type: array
      items: File
    doc: One or more files to upload as new datasets.
    inputBinding:
      position: 2
  - id: dbkey
    type:
      - 'null'
      - string
    doc: dbkey to assign to files
    inputBinding:
      position: 103
      prefix: --dbkey
  - id: file_type
    type:
      - 'null'
      - string
    doc: Galaxy data type to assign the files to. Must be a valid Galaxy data 
      type. If not 'auto' then all files will be assigned the same type.
    inputBinding:
      position: 103
      prefix: --file-type
  - id: link
    type:
      - 'null'
      - boolean
    doc: Create symlinks to files on server (only valid if used with --server; 
      default is to copy files into Galaxy)
    inputBinding:
      position: 103
      prefix: --link
  - id: server
    type:
      - 'null'
      - boolean
    doc: Upload files from the Galaxy server file system (default is to upload 
      files from local system)
    inputBinding:
      position: 103
      prefix: --server
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nebulizer:0.7.1--pyh5e36f6f_0
stdout: nebulizer_add_library_datasets.out
