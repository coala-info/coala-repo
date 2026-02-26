cwlVersion: v1.2
class: CommandLineTool
baseCommand: univariate_wrapper.R
label: univariate
doc: "Performs univariate analysis on the input data matrix, sample metadata, and
  variable metadata.\n\nTool homepage: https://github.com/ServiceNow/N-BEATS"
inputs:
  - id: data_matrix_in
    type: File
    doc: Input data matrix file
    inputBinding:
      position: 1
  - id: sample_metadata_in
    type: File
    doc: Input sample metadata file
    inputBinding:
      position: 2
  - id: variable_metadata_in
    type: File
    doc: Input variable metadata file
    inputBinding:
      position: 3
  - id: fac_c
    type: string
    doc: Factor for categorical variables
    inputBinding:
      position: 4
  - id: qual
    type: string
    doc: Quality control parameter
    inputBinding:
      position: 5
  - id: tes_c
    type: string
    doc: Test for categorical variables
    inputBinding:
      position: 6
  - id: kruskal
    type: string
    doc: Kruskal-Wallis test flag
    inputBinding:
      position: 7
  - id: adj_c
    type: string
    doc: Adjustment for multiple comparisons
    inputBinding:
      position: 8
  - id: fdr
    type: string
    doc: False discovery rate control
    inputBinding:
      position: 9
  - id: thr_n
    type: float
    doc: Threshold for significance
    inputBinding:
      position: 10
outputs:
  - id: variable_metadata_out
    type: File
    doc: Output variable metadata file
    outputBinding:
      glob: '*.out'
  - id: figure
    type: File
    doc: Output figure file
    outputBinding:
      glob: '*.out'
  - id: information
    type: File
    doc: Output information file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/univariate:phenomenal-v2.2.6_cv1.3.32
