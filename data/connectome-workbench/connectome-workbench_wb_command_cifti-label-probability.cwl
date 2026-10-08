cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-label-probability
label: connectome-workbench_wb_command_cifti-label-probability
doc: "This command outputs a set of soft ROIs, one for each label in the input, where the value is how many of the input maps had that label at that vertex/voxel, divided by the number of input maps.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_maps
    type: File
    doc: cifti dlabel file containing individual label maps from many subjects
    inputBinding:
      position: 1
  - id: probability_dscalar_out
    type: string
    doc: the relative frequencies of each label at each vertex/voxel
    inputBinding:
      position: 2
  - id: exclude_unlabeled
    type:
      - 'null'
      - boolean
    doc: don't make a probability map of the unlabeled key
    inputBinding:
      position: 3
      prefix: -exclude-unlabeled
outputs:
  - id: probability_dscalar_out_file
    type: File
    doc: the relative frequencies of each label at each vertex/voxel
    outputBinding:
      glob: $(inputs.probability_dscalar_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
