cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dimspy
  - get-peaklists
label: dimspy_get-peaklists
doc: "Get peaklists from HDF5 files.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: input
    type:
      type: array
      items: File
      inputBinding:
        prefix: --input
    doc: Single or Multiple HDF5 files that contain a peak matrix object from 
      one of the processing steps.
    inputBinding:
      position: 101
  - id: output_path
    type: string
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peaklist objects to.
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
