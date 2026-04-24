cwlVersion: v1.2
class: CommandLineTool
baseCommand: Rscript
label: batch_brb
doc: "Wrapper scripts for batch correction.\n\nTool homepage: https://github.com/erin-r-butterfield/batch_brb"
inputs:
  - id: dataMatrix
    type: File
    doc: Input data matrix file
    inputBinding:
      position: 1
  - id: sampleMetadata
    type: File
    doc: Input sample metadata file
    inputBinding:
      position: 2
  - id: variableMetadata
    type: File
    doc: Input variable metadata file
    inputBinding:
      position: 3
  - id: method
    type: string
    doc: Set the method; can set to "all_loess_pool" or "all_loess_sample" (for 
      all_loess_wrapper) or "linear", "lowess" or "loess" (for wrapper)
    inputBinding:
      position: 4
  - id: span
    type: string
    doc: Set the span condition; set to "none" if method is set to "linear"
    inputBinding:
      position: 5
  - id: analyse
    type: string
    doc: Must be set to "batch_correction"
    inputBinding:
      position: 106
      prefix: --analyse
  - id: batch_col_name
    type:
      - 'null'
      - string
    doc: The column name for batch.
    inputBinding:
      position: 106
      prefix: --batch_col_name
  - id: detail
    type:
      - 'null'
      - string
    doc: Set the detail value
    inputBinding:
      position: 106
      prefix: --detail
  - id: injection_order_col_name
    type:
      - 'null'
      - string
    doc: The column name for the injection order.
    inputBinding:
      position: 106
      prefix: --injection_order_col_name
  - id: loess
    type:
      - 'null'
      - boolean
    doc: Call the script as "batch_correction_all_loess_wrapper.R"; otherwise 
      call it as "batch_correction_wrapper.R" one
    inputBinding:
      position: 106
      prefix: --loess
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: Set the ref_factor value
    inputBinding:
      position: 106
      prefix: --ref_factor
  - id: sample_type_col_name
    type:
      - 'null'
      - string
    doc: The column name for the sample types.
    inputBinding:
      position: 106
      prefix: --sample_type_col_name
  - id: sample_type_tags
    type:
      - 'null'
      - string
    doc: 'The tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample).'
    inputBinding:
      position: 106
      prefix: --sample_type_tags
outputs:
  - id: dataMatrix_out
    type: File
    doc: Set the output data matrix file
    outputBinding:
      glob: '*.out'
  - id: variableMetadata_out
    type: File
    doc: Set the output variable metadata file
    outputBinding:
      glob: '*.out'
  - id: graph_output
    type: File
    doc: Set the output graph file
    outputBinding:
      glob: '*.out'
  - id: rdata_output
    type: File
    doc: Set the output Rdata file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
