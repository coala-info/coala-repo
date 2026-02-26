cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript batch_correction_docker_wrapper.R
label: batch_brb_batch_correction_wrapper.r
doc: "Wrapper script for batch correction, can call different underlying batch correction
  methods.\n\nTool homepage: https://github.com/erin-r-butterfield/batch_brb"
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
    doc: Input data matrix file
    inputBinding:
      position: 101
  - id: detail
    type:
      - 'null'
      - string
    doc: Set the detail value; (if span value is set to NULL, optional)
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
    doc: Set the method; can be 'all_loess_pool' or 'all_loess_sample' for loess
      wrapper, or 'linear', 'lowess', or 'loess' for the standard wrapper.
    inputBinding:
      position: 101
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: Set the ref_factor value; (if span value is set to NULL, optional)
    inputBinding:
      position: 101
  - id: sampleMetadata
    type: File
    doc: Input sample metadata file
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
    doc: Set the span condition. Set to 'none' if method is 'linear'.
    inputBinding:
      position: 101
  - id: variableMetadata
    type: File
    doc: Input variable metadata file
    inputBinding:
      position: 101
outputs:
  - id: dataMatrix_out
    type: File
    doc: Output data matrix file
    outputBinding:
      glob: $(inputs.dataMatrix_out)
  - id: variableMetadata_out
    type: File
    doc: Output variable metadata file
    outputBinding:
      glob: $(inputs.variableMetadata_out)
  - id: graph_output
    type: File
    doc: Output graph file
    outputBinding:
      glob: $(inputs.graph_output)
  - id: rdata_output
    type: File
    doc: Output Rdata file
    outputBinding:
      glob: $(inputs.rdata_output)
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
