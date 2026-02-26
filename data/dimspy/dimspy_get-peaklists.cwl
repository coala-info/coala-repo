cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy get-peaklists
label: dimspy_get-peaklists
doc: "Get peaklists from HDF5 files.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
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
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peaklist objects to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
