cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dimspy
  - get-average-peaklist
label: dimspy_get-average-peaklist
doc: "Calculates the average peaklist from input HDF5 files.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: Single or Multiple HDF5 files that contain a peak matrix object from 
      one of the processing steps.
    inputBinding:
      position: 101
      prefix: --input
  - id: name_peaklist
    type: string
    doc: Name of the peaklist.
    inputBinding:
      position: 101
      prefix: --name-peaklist
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peaklist object to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
