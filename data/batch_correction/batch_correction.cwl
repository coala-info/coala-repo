cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript batch_correction_docker_wrapper.R
label: batch_correction
doc: "Wrapper script for batch correction, which can call either batch_correction_all_loess_wrapper.R
  or batch_correction_wrapper.R based on the --loess option.\n\nTool homepage: https://github.com/USTCPCS/CVPR2018_attention"
inputs:
  - id: analyse
    type: string
    doc: Must be set to "batch_correction".
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
    doc: Set the input data matrix file.
    inputBinding:
      position: 101
  - id: detail
    type:
      - 'null'
      - string
    doc: Set the detail value (if span value is set to NULL, optional).
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
    doc: If TRUE, call the script as "batch_correction_all_loess_wrapper.R"; 
      otherwise call it as "batch_correction_wrapper.R".
    default: 'FALSE'
    inputBinding:
      position: 101
      prefix: --loess
  - id: method
    type: string
    doc: Set the method. For all_loess_wrapper, can be "all_loess_pool" or 
      "all_loess_sample". For wrapper, can be "linear", "lowess", or "loess".
    inputBinding:
      position: 101
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: Set the ref_factor value (if span value is set to NULL, optional).
    inputBinding:
      position: 101
  - id: sampleMetadata
    type: File
    doc: Set the input sample metadata file.
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
    doc: 'The tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample).'
    inputBinding:
      position: 101
  - id: span
    type: string
    doc: Set the span condition. Set to "none" if method is set to "linear".
    inputBinding:
      position: 101
  - id: variableMetadata
    type: File
    doc: Set the input variable metadata file.
    inputBinding:
      position: 101
outputs:
  - id: dataMatrix_out
    type: File
    doc: Set the output data matrix file.
    outputBinding:
      glob: $(inputs.dataMatrix_out)
  - id: variableMetadata_out
    type: File
    doc: Set the output variable metadata file.
    outputBinding:
      glob: $(inputs.variableMetadata_out)
  - id: graph_output
    type: File
    doc: Set the output graph file.
    outputBinding:
      glob: $(inputs.graph_output)
  - id: rdata_output
    type: File
    doc: Set the output Rdata file.
    outputBinding:
      glob: $(inputs.rdata_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
