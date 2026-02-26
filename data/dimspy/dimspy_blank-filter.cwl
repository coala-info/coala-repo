cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - dimspy
  - blank-filter
label: dimspy_blank-filter
doc: "Filters a peak matrix based on blank samples.\n\nTool homepage: https://github.com/computational-metabolomics/dimspy"
inputs:
  - id: blank_label
    type: string
    doc: Class label for blanks.
    inputBinding:
      position: 101
      prefix: --blank-label
  - id: function
    type:
      - 'null'
      - string
    doc: Select function to calculate blank intenstiy.
    inputBinding:
      position: 101
      prefix: --function
  - id: input
    type: File
    doc: HDF5 file or tab-delimited file that contains a peak matrix (object).
    inputBinding:
      position: 101
      prefix: --input
  - id: labels
    type:
      - 'null'
      - File
    doc: Tab delimited file with at least two columns named 'filename' and 
      'classLabel'.
    inputBinding:
      position: 101
      prefix: --labels
  - id: min_fold_change
    type:
      - 'null'
      - float
    doc: Minium fold change blank versus sample.
    inputBinding:
      position: 101
      prefix: --min-fold-change
  - id: min_fraction
    type:
      - 'null'
      - float
    doc: Minium fold change blank versus sample.
    inputBinding:
      position: 101
      prefix: --min-fraction
  - id: remove_blank_samples
    type:
      - 'null'
      - boolean
    doc: Remove blank samples from peak matrix.
    inputBinding:
      position: 101
      prefix: --remove-blank-samples
outputs:
  - id: output
    type: File
    doc: HDF5 file to save the peak matrix object to.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dimspy:2.0.0--pyhdfd78af_1
