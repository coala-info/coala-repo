cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-foci-list-coords'
label: connectome-workbench_wb_command_foci-list-coords
doc: "Output foci coordinates in a text file, and optionally the focus names in a second text file.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: foci_file
    type: File
    doc: input foci file
    inputBinding:
      position: 1
  - id: coord_file_out
    type: string
    doc: output - the output coordinate text file
    inputBinding:
      position: 2
  - id: names_out
    type:
      - 'null'
      - string
    doc: output - text file to put foci names in
    inputBinding:
      position: 3
      prefix: '-names-out'
outputs:
  - id: coords
    type: File
    doc: the output coordinate text file
    outputBinding:
      glob: $(inputs.coord_file_out)
  - id: names
    type:
      - 'null'
      - File
    doc: the foci names text file
    outputBinding:
      glob: $(inputs.names_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
