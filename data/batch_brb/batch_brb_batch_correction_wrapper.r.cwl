cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - /files/batch_correction/batch_correction_docker_wrapper.R
label: batch_brb_batch_correction_wrapper.r
doc: "Wrapper script for batch correction, can call different underlying batch correction
  methods.\n\nTool homepage: https://github.com/workflow4metabolomics/batch_correction"
inputs:
  - id: dataMatrix
    type: File
    doc: Input data matrix file
    inputBinding:
      position: 1
      prefix: dataMatrix
  - id: sampleMetadata
    type: File
    doc: Input sample metadata file
    inputBinding:
      position: 2
      prefix: sampleMetadata
  - id: variableMetadata
    type: File
    doc: Input variable metadata file
    inputBinding:
      position: 3
      prefix: variableMetadata
  - id: analyse
    type: string
    default: batch_correction
    doc: Must be set to "batch_correction"
    inputBinding:
      position: 0
      prefix: analyse
  - id: method
    type: string
    doc: Set the method; can set to "linear", "lowess" or "loess"
    inputBinding:
      position: 4
      prefix: method
  - id: span
    type: string
    doc: Set the span condition; set to "none" if method is set to "linear"
    inputBinding:
      position: 5
      prefix: span
  - id: ref_factor
    type:
      - 'null'
      - string
    default: batch
    doc: Set the ref_factor value (if span value is set to NULL, optional)
    inputBinding:
      position: 6
      prefix: ref_factor
  - id: detail
    type:
      - 'null'
      - string
    default: 'no'
    doc: Set the detail value, "no", "plot" or "reg" (if span value is set to NULL, optional)
    inputBinding:
      position: 7
      prefix: detail
  - id: valnull
    type:
      - 'null'
      - string
    default: '0'
    doc: What to do with generated negative or infinite values, "0" or "NA"
      (wrapper only; used by the Galaxy tool)
    inputBinding:
      position: 8
      prefix: valnull
  - id: batch_col_name
    type:
      - 'null'
      - string
    doc: The column name for batch (default "batch")
    inputBinding:
      position: 20
      prefix: batch_col_name
  - id: injection_order_col_name
    type:
      - 'null'
      - string
    doc: The column name for the injection order (default "injectionOrder")
    inputBinding:
      position: 21
      prefix: injection_order_col_name
  - id: sample_type_col_name
    type:
      - 'null'
      - string
    doc: The column name for the sample types (default "sampleType")
    inputBinding:
      position: 22
      prefix: sample_type_col_name
  - id: sample_type_tags
    type:
      - 'null'
      - string
    doc: 'The tags used inside the sample type column, defined as key/value pairs
      separated by commas (example: blank=blank,pool=pool,sample=sample)'
    inputBinding:
      position: 23
      prefix: sample_type_tags
  - id: dataMatrix_out_path
    type: string
    default: dataMatrix_out.tsv
    doc: Output data matrix file name
    inputBinding:
      position: 30
      prefix: dataMatrix_out
  - id: variableMetadata_out_path
    type: string
    default: variableMetadata_out.tsv
    doc: Output variable metadata file name
    inputBinding:
      position: 31
      prefix: variableMetadata_out
  - id: graph_output_path
    type: string
    default: graph_output.pdf
    doc: Output graph file name (PDF)
    inputBinding:
      position: 32
      prefix: graph_output
  - id: rdata_output_path
    type: string
    default: rdata_output.Rdata
    doc: Output Rdata file name
    inputBinding:
      position: 33
      prefix: rdata_output
outputs:
  - id: dataMatrix_out
    type: File
    doc: Output data matrix file
    outputBinding:
      glob: $(inputs.dataMatrix_out_path)
  - id: variableMetadata_out
    type: File
    doc: Output variable metadata file
    outputBinding:
      glob: $(inputs.variableMetadata_out_path)
  - id: graph_output
    type: File
    doc: Output graph file
    outputBinding:
      glob: $(inputs.graph_output_path)
  - id: rdata_output
    type: File
    doc: Output Rdata file
    outputBinding:
      glob: $(inputs.rdata_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/batch_correction:phenomenal-v2.2.3_cv1.1.15
