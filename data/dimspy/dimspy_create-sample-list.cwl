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
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Text file to write to.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
