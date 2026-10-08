cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -volume-label-probability
label: connectome-workbench_wb_command_volume-label-probability
doc: "This command outputs a set of soft ROIs, one for each label in the input, where the value is how many of the input maps had that label at that voxel, divided by the number of input maps.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_maps
    type: File
    doc: "volume label file containing individual label maps from many subjects"
    inputBinding:
      position: 1
  - id: probability_out
    type: string
    doc: "output - the relative frequencies of each label at each voxel"
    inputBinding:
      position: 2
  - id: exclude_unlabeled
    type:
      - 'null'
      - boolean
    doc: "don't make a probability map of the unlabeled key"
    inputBinding:
      position: 3
      prefix: -exclude-unlabeled
outputs:
  - id: probability_volume
    type: File
    doc: "the relative frequencies of each label at each voxel"
    outputBinding:
      glob: $(inputs.probability_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
