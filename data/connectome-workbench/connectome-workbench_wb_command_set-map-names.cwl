cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -set-map-names
label: connectome-workbench_wb_command_set-map-names
doc: 'Sets the name of one or more maps for metric, shape, label, volume, cifti scalar
  or cifti label files. If the -name-file option is not specified, the -map option
  must be specified at least once. The -map option cannot be used when -name-file
  is specified.


  Tool homepage: https://www.humanconnectome.org/software/connectome-workbench'
requirements:
  - class: SchemaDefRequirement
    types:
      - name: map_rec
        type: record
        fields:
          - name: index
            type: int
            doc: the map index to change the name of
            inputBinding:
              position: 1
          - name: new_name
            type: string
            doc: the name to set for the map
            inputBinding:
              position: 2
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.data_file)
        writable: true
inputs:
  - id: data_file
    type: File
    doc: the file to set the map names of
    inputBinding:
      position: 1
  - id: name_file
    type:
      - 'null'
      - File
    doc: use a text file to replace all map names
    inputBinding:
      position: 2
      prefix: -name-file
  - id: map
    type:
      - 'null'
      - type: array
        items: map_rec
        inputBinding:
          prefix: -map
    doc: specify a map to set the name of
    inputBinding:
      position: 2
outputs:
  - id: data_file_modified
    type: File
    doc: the input file, modified in place
    outputBinding:
      glob: $(inputs.data_file.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
