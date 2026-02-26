cwlVersion: v1.2
class: CommandLineTool
baseCommand: dimspy mv-sample-filter
label: dimspy_mv-sample-filter
doc: "Filters samples based on the maximum fraction of missing values.\n\nTool homepage:
  https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: input
    type: File
    doc: HDF5 file file that contains a peak matrix object.
    inputBinding:
      position: 101
      prefix: --input
  - id: max_fraction
    type:
      - 'null'
      - float
    doc: Maximum percentage of missing values allowed across a sample.
    inputBinding:
      position: 101
      prefix: --max-fraction
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peak matrix object to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
