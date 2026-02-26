cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy create-sample-list
label: dimspy_create-sample-list
doc: "Create a sample list from an HDF5 peak matrix.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: delimiter
    type:
      - 'null'
      - string
    doc: Values on each line of the file are separated by this character.
    default: tab
    inputBinding:
      position: 101
      prefix: --delimiter
  - id: input
    type: File
    doc: HDF5 file that contains a peak matrix object from one of the processing
      steps.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: Text file to write to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
