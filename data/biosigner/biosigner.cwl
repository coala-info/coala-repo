cwlVersion: v1.2
class: CommandLineTool
baseCommand: biosigner_wrapper.R
label: biosigner
doc: "Wrapper script for biosigner\n\nTool homepage: https://github.com/workflow4metabolomics/biosigner"
inputs:
  - id: data_matrix_in
    type: File
    doc: Input data matrix
    inputBinding:
      position: 1
  - id: sample_metadata_in
    type: File
    doc: Input sample metadata
    inputBinding:
      position: 2
  - id: variable_metadata_in
    type: File
    doc: Input variable metadata
    inputBinding:
      position: 3
  - id: resp_c
    type:
      type: array
      items: string
    doc: Response variable(s)
    inputBinding:
      position: 4
  - id: method_c
    type:
      type: array
      items: string
    doc: Method(s) to use
    inputBinding:
      position: 5
  - id: boot_i
    type:
      type: array
      items: int
    doc: Number of bootstrap iterations
    inputBinding:
      position: 6
  - id: tier_c
    type:
      type: array
      items: string
    doc: Tier(s) to consider
    inputBinding:
      position: 7
  - id: pval_n
    type:
      type: array
      items: float
    doc: P-value threshold(s)
    inputBinding:
      position: 8
  - id: seed_i
    type:
      type: array
      items: int
    doc: Random seed(s)
    inputBinding:
      position: 9
outputs:
  - id: variable_metadata_out
    type: File
    doc: Output variable metadata file
    outputBinding:
      glob: '*.out'
  - id: figure_tier
    type: File
    doc: Output file for tier figure
    outputBinding:
      glob: '*.out'
  - id: figure_boxplot
    type: File
    doc: Output file for boxplot figure
    outputBinding:
      glob: '*.out'
  - id: information
    type: File
    doc: Output file for information
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/biosigner:phenomenal-v2.2.8_cv1.4.26
