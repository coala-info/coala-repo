cwlVersion: v1.2
class: CommandLineTool
baseCommand: turbocor compute
label: turbocor_compute
doc: "Compute entries of a thresholded correlation matrix. Output to an HDF5 file.\n\
  \nTool homepage: https://github.com/dcjones/turbocor"
inputs:
  - id: input_features
    type: File
    doc: Feature matrix in HDF5 format.
    inputBinding:
      position: 1
  - id: tempfile
    type:
      - 'null'
      - File
    doc: Path to temporary file to use.
    inputBinding:
      position: 2
  - id: dataset
    type:
      - 'null'
      - string
    doc: Name of dataset in input HDF5 file.
    inputBinding:
      position: 103
      prefix: --dataset
  - id: lower_bound
    type:
      - 'null'
      - float
    doc: Suppress abs correlations below this number.
    inputBinding:
      position: 103
      prefix: --lower-bound
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use. (By default all cpu cores are used.)
    inputBinding:
      position: 103
      prefix: --threads
  - id: transpose
    type:
      - 'null'
      - boolean
    doc: Dataset matrix should be transposed
    inputBinding:
      position: 103
      prefix: --transpose
outputs:
  - id: output_correlation
    type: File
    doc: Output sparse COO correlation matrix in HDF5 format.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/turbocor:0.1.1--h5177ac6_0
