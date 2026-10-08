cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-copy-extensions
label: connectome-workbench_wb_command_volume-copy-extensions
doc: "This command copies the information in a volume file that isn't a critical part of the standard header or data matrix, e.g. map names, palette settings, label tables. If -drop-unknown is not specified, it also copies similar kinds of information set by other software.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: data_volume
    type: File
    doc: "the volume file containing the voxel data to use"
    inputBinding:
      position: 1
  - id: extension_volume
    type: File
    doc: "the volume file containing the extensions to use"
    inputBinding:
      position: 2
  - id: volume_out
    type: string
    doc: "output - the output volume"
    inputBinding:
      position: 3
  - id: drop_unknown
    type:
      - 'null'
      - boolean
    doc: "don't copy extensions that workbench doesn't understand"
    inputBinding:
      position: 4
      prefix: -drop-unknown
outputs:
  - id: output_volume
    type: File
    doc: "the output volume"
    outputBinding:
      glob: $(inputs.volume_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
