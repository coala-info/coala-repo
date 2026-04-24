cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript batch_correction_docker_wrapper.R
label: batch_brb_batch_correction_all_loess_wrapper.r
doc: "Wrapper script for batch correction, with options to use LOESS-based methods.\n\
  \nTool homepage: https://github.com/erin-r-butterfield/batch_brb"
inputs:
  - id: data_matrix
    type: File
    doc: Input data matrix file
    inputBinding:
      position: 1
  - id: sample_metadata
    type: File
    doc: Input sample metadata file
    inputBinding:
      position: 2
  - id: variable_metadata
    type: File
    doc: Input variable metadata file
    inputBinding:
      position: 3
  - id: method
    type: string
    doc: Set the method; can set to "all_loess_pool" or "all_loess_sample"
    inputBinding:
      position: 4
  - id: span
    type: string
    doc: Set the span condition
    inputBinding:
      position: 5
  - id: analyse
    type: string
    doc: Must be set to "batch_correction"
    inputBinding:
      position: 106
  - id: batch_col_name
    type:
      - 'null'
      - string
    doc: The column name for batch
    inputBinding:
      position: 106
  - id: detail
    type:
      - 'null'
      - string
    doc: Set the detail value; (if span value is set to NULL, optional)
    inputBinding:
      position: 106
  - id: injection_order_col_name
    type:
      - 'null'
      - string
    doc: The column name for the injection order
    inputBinding:
      position: 106
  - id: loess
    type:
      - 'null'
      - boolean
    doc: Call the script as "batch_correction_all_loess_wrapper.R"; otherwise 
      call it as "batch_correction_wrapper.R" one
    inputBinding:
      position: 106
      prefix: --loess
  - id: method_batch_correction
    type: string
    doc: Set the method; can set to "linear", "lowess" or "loess"
    inputBinding:
      position: 106
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: Set the ref_factor value; (if span value is set to NULL, optional)
    inputBinding:
      position: 106
  - id: sample_type_col_name
    type:
      - 'null'
      - string
    doc: The column name for the sample types
    inputBinding:
      position: 106
  - id: sample_type_tags
    type:
      - 'null'
      - string
    doc: 'The tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample)'
    inputBinding:
      position: 106
  - id: span_condition
    type: string
    doc: Set the span condition; set to "none" if method is set to "linear"
    inputBinding:
      position: 106
outputs:
  - id: data_matrix_out
    type: File
    doc: Output data matrix file
    outputBinding:
      glob: '*.out'
  - id: variable_metadata_out
    type: File
    doc: Output variable metadata file
    outputBinding:
      glob: '*.out'
  - id: graph_output
    type: File
    doc: Output graph file
    outputBinding:
      glob: '*.out'
  - id: rdata_output
    type: File
    doc: Output Rdata file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
