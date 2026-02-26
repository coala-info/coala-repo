cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy remove-samples
label: dimspy_remove-samples
doc: "Removes samples from a peak matrix or peaklist object.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: sample_names
    type:
      type: array
      items: string
    doc: Sample name(s)
    inputBinding:
      position: 101
      prefix: --sample-names
  - id: source
    type: File
    doc: HDF5 file that contains a peak matrix object or list of peaklist 
      objects from one of the processing steps.
    inputBinding:
      position: 101
      prefix: --input
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peak matrix object or peaklist objects to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
