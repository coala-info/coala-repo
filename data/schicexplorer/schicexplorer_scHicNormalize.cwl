cwlVersion: v1.2
class: CommandLineTool
baseCommand: schicexplorer_scHicNormalize
label: schicexplorer_scHicNormalize
doc: "Normalize scHi-C matrices.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: The single cell Hi-C interaction matrices to investigate for QC. Needs 
      to be in scool format
    inputBinding:
      position: 101
      prefix: --matrix
  - id: maximum_region_to_consider
    type:
      - 'null'
      - int
    doc: To compute the normalization factor for the normalization mode 
      'smallest' and 'read_count', consider only this genomic distance around 
      the diagonal.
    default: 30000000
    inputBinding:
      position: 101
      prefix: --maximumRegionToConsider
  - id: normalize
    type: string
    doc: Normalize to a) all matrices to the lowest read count of the given 
      matrices, b) all to a given read coverage value or c) to a multiplicative 
      value
    inputBinding:
      position: 101
      prefix: --normalize
  - id: set_to_zero_threshold
    type:
      - 'null'
      - float
    doc: Values smaller as this threshold are set to 0.
    default: 1.0
    inputBinding:
      position: 101
      prefix: --setToZeroThreshold
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module.
    default: 4
    inputBinding:
      position: 101
      prefix: --threads
  - id: value
    type:
      - 'null'
      - float
    doc: This value is used to either be interpreted as the desired read_count 
      or the multiplicative value. This depends on the value for --normalize
    default: 1
    inputBinding:
      position: 101
      prefix: --value
outputs:
  - id: out_file_name
    type: File
    doc: File name of the normalized scool matrix.
    outputBinding:
      glob: $(inputs.out_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
