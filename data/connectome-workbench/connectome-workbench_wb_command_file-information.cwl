cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -file-information
label: connectome-workbench_wb_command_file-information
doc: "List information about the content of a data file. Only one -only option
  may be specified. The information listed when no -only option is present is
  dependent upon the type of data file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: data_file
    type: File
    doc: data file
    inputBinding:
      position: 1
  - id: no_map_info
    type:
      - 'null'
      - boolean
    doc: do not show map information for files that support maps
    inputBinding:
      position: 2
      prefix: -no-map-info
  - id: only_step_interval
    type:
      - 'null'
      - boolean
    doc: suppress normal output, print the interval between maps
    inputBinding:
      position: 2
      prefix: -only-step-interval
  - id: only_number_of_maps
    type:
      - 'null'
      - boolean
    doc: suppress normal output, print the number of maps
    inputBinding:
      position: 2
      prefix: -only-number-of-maps
  - id: only_map_names
    type:
      - 'null'
      - boolean
    doc: suppress normal output, print the names of all maps
    inputBinding:
      position: 2
      prefix: -only-map-names
  - id: only_metadata
    type:
      - 'null'
      - boolean
    doc: suppress normal output, print file metadata
    inputBinding:
      position: 2
      prefix: -only-metadata
  - id: metadata_key
    type:
      - 'null'
      - string
    doc: with only_metadata, only print the metadata for this key, with no
      formatting
    inputBinding:
      position: 3
      prefix: -key
  - id: only_cifti_xml
    type:
      - 'null'
      - boolean
    doc: suppress normal output, print the cifti xml if the file type has it
    inputBinding:
      position: 2
      prefix: -only-cifti-xml
  - id: output_name
    type:
      - 'null'
      - string
    doc: name of the file that receives the standard output
    default: file_information.txt
outputs:
  - id: information
    type: File
    doc: text report about the file content
    outputBinding:
      glob: $(inputs.output_name)
stdout: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
