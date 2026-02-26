cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript batch_correction_docker_wrapper.R
label: batch_correction_batch_correction_wrapper.r
doc: "Wrapper script for batch correction, which can call different batch correction
  methods.\n\nTool homepage: https://github.com/USTCPCS/CVPR2018_attention"
inputs:
  - id: analyse
    type: string
    doc: Must be set to 'batch_correction'.
    inputBinding:
      position: 101
  - id: batch_col_name
    type:
      - 'null'
      - string
    doc: The column name for batch.
    default: batch
    inputBinding:
      position: 101
  - id: dataMatrix
    type: File
    doc: Input data matrix file.
    inputBinding:
      position: 101
  - id: detail
    type:
      - 'null'
      - string
    doc: Set the detail value (optional, if span value is set to NULL).
    inputBinding:
      position: 101
  - id: injection_order_col_name
    type:
      - 'null'
      - string
    doc: The column name for the injection order.
    default: injectionOrder
    inputBinding:
      position: 101
  - id: loess
    type:
      - 'null'
      - boolean
    doc: If TRUE, call batch_correction_all_loess_wrapper.R; otherwise call 
      batch_correction_wrapper.R.
    inputBinding:
      position: 101
      prefix: --loess
  - id: method
    type: string
    doc: Method to use for batch correction. Can be 'all_loess_pool', 
      'all_loess_sample', 'linear', 'lowess', or 'loess'.
    inputBinding:
      position: 101
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: Set the ref_factor value (optional, if span value is set to NULL).
    inputBinding:
      position: 101
  - id: sampleMetadata
    type: File
    doc: Input sample metadata file.
    inputBinding:
      position: 101
  - id: sample_type_col_name
    type:
      - 'null'
      - string
    doc: The column name for the sample types.
    default: sampleType
    inputBinding:
      position: 101
  - id: sample_type_tags
    type:
      - 'null'
      - string
    doc: 'Tags used inside the sample type column, defined as key/value pairs separated
      by commas (example: blank=blank,pool=pool,sample=sample).'
    inputBinding:
      position: 101
  - id: span
    type: string
    doc: Span condition for LOESS/LOWESS methods. Set to 'none' if method is 
      'linear'.
    inputBinding:
      position: 101
  - id: variableMetadata
    type: File
    doc: Input variable metadata file.
    inputBinding:
      position: 101
outputs:
  - id: dataMatrix_out
    type: File
    doc: Output data matrix file.
    outputBinding:
      glob: $(inputs.dataMatrix_out)
  - id: variableMetadata_out
    type: File
    doc: Output variable metadata file.
    outputBinding:
      glob: $(inputs.variableMetadata_out)
  - id: graph_output
    type: File
    doc: Output graph file.
    outputBinding:
      glob: $(inputs.graph_output)
  - id: rdata_output
    type: File
    doc: Output Rdata file.
    outputBinding:
      glob: $(inputs.rdata_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
