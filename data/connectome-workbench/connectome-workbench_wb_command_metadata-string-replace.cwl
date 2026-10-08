cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-metadata-string-replace'
label: connectome-workbench_wb_command_metadata-string-replace
doc: "Replace a string in all metadata of a file. Replaces all occurrences of <find-string> in the metadata and map names of <input-file> with <replace-string>.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: input_file
    type: File
    doc: the file to replace metadata in
    inputBinding:
      position: 1
  - id: find_string
    type: string
    doc: the string to find
    inputBinding:
      position: 2
  - id: replace_string
    type: string
    doc: the string to replace <find-string> with
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: output - the name to save the modified file as
    inputBinding:
      position: 4
  - id: case_insensitive
    type:
      - 'null'
      - boolean
    doc: match with case variation also
    inputBinding:
      position: 5
      prefix: '-case-insensitive'
outputs:
  - id: modified_file
    type: File
    doc: the modified file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
