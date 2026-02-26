cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - batch_correction_docker_wrapper.R
label: batch_correction_batch_correction_all_loess_wrapper.r
doc: "Wrapper script for batch correction, with options to call different correction
  methods.\n\nTool homepage: https://github.com/USTCPCS/CVPR2018_attention"
inputs:
  - id: analyse
    type: string
    doc: must be set to "batch_correction"
    inputBinding:
      position: 101
  - id: batch_col_name
    type:
      - 'null'
      - string
    doc: the column name for batch
    default: batch
    inputBinding:
      position: 101
  - id: data_matrix
    type: File
    doc: set the input data matrix file
    inputBinding:
      position: 101
  - id: detail
    type:
      - 'null'
      - string
    doc: set the detail value; (if span value is set to NULL, optional)
    inputBinding:
      position: 101
  - id: injection_order_col_name
    type:
      - 'null'
      - string
    doc: the column name for the injection order
    default: injectionOrder
    inputBinding:
      position: 101
  - id: loess
    type:
      - 'null'
      - boolean
    doc: Call the script as "batch_correction_all_loess_wrapper.R"; otherwise 
      call it as "batch_correction_wrapper.R" one
    default: 'TRUE'
    inputBinding:
      position: 101
      prefix: --loess
  - id: method
    type: string
    doc: set the method; can set to "all_loess_pool" or "all_loess_sample"
    inputBinding:
      position: 101
  - id: method_alt
    type: string
    doc: set the method; can set to "linear", "lowess" or "loess"
    inputBinding:
      position: 101
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: set the ref_factor value; (if span value is set to NULL, optional)
    inputBinding:
      position: 101
  - id: sample_metadata
    type: File
    doc: set the input sample metadata file
    inputBinding:
      position: 101
  - id: sample_type_col_name
    type:
      - 'null'
      - string
    doc: the column name for the sample types
    default: sampleType
    inputBinding:
      position: 101
  - id: sample_type_tags
    type:
      - 'null'
      - string
    doc: 'the tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample)'
    inputBinding:
      position: 101
  - id: span
    type: string
    doc: set the span condition
    inputBinding:
      position: 101
  - id: span_alt
    type: string
    doc: set the span condition; set to "none" if method is set to "linear"
    inputBinding:
      position: 101
  - id: variable_metadata
    type: File
    doc: set the input variable metadata file
    inputBinding:
      position: 101
outputs:
  - id: data_matrix_out
    type: File
    doc: set the output data matrix file
    outputBinding:
      glob: $(inputs.data_matrix_out)
  - id: variable_metadata_out
    type: File
    doc: set the output variable metadata file
    outputBinding:
      glob: $(inputs.variable_metadata_out)
  - id: graph_output
    type: File
    doc: set the output graph file
    outputBinding:
      glob: $(inputs.graph_output)
  - id: rdata_output
    type: File
    doc: set the output Rdata file
    outputBinding:
      glob: $(inputs.rdata_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
