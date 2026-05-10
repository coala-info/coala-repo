cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - batch_correction_docker_wrapper.R
label: batchcorrection_batch_correction_all_loess_wrapper.r
doc: "Wrapper script for batch correction, with options to use LOESS or other methods.\n\
  \nTool homepage: https://github.com/carpenter-singh-lab/2023_Arevalo_NatComm_BatchCorrection"
inputs:
  - id: analyse
    type: string
    doc: must be set to "batch_correction"
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
    doc: set the detail value
    inputBinding:
      position: 101
  - id: loess
    type:
      - 'null'
      - boolean
    doc: Call the script as "batch_correction_all_loess_wrapper.R"; otherwise 
      call it as "batch_correction_wrapper.R" one
    inputBinding:
      position: 101
      prefix: --loess
  - id: method
    type: string
    doc: set the method; can set to "all_loess_pool" or "all_loess_sample"
    inputBinding:
      position: 101
  - id: ref_factor
    type:
      - 'null'
      - string
    doc: set the ref_factor value
    inputBinding:
      position: 101
  - id: sample_metadata
    type: File
    doc: set the input sample metadata file
    inputBinding:
      position: 101
  - id: span
    type: string
    doc: set the span condition
    inputBinding:
      position: 101
  - id: variable_metadata
    type: File
    doc: set the input variable metadata file
    inputBinding:
      position: 101
  - id: data_matrix_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `data_matrix_out_path`
    inputBinding:
      position: 102
      prefix: --data-matrix-out
  - id: graph_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `graph_output_path`
    inputBinding:
      position: 103
      prefix: --graph-output
  - id: rdata_output_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `rdata_output_path`
    inputBinding:
      position: 104
      prefix: --rdata-output
  - id: variable_metadata_out_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `variable_metadata_out_path`
    inputBinding:
      position: 105
      prefix: --variable-metadata-out
outputs:
  - id: data_matrix_out
    type: File
    doc: set the output data matrix file
    outputBinding:
      glob: $(inputs.data_matrix_out_path)
  - id: variable_metadata_out
    type: File
    doc: set the output variable metadata file
    outputBinding:
      glob: $(inputs.variable_metadata_out_path)
  - id: graph_output
    type: File
    doc: set the output graph file
    outputBinding:
      glob: $(inputs.graph_output_path)
  - id: rdata_output
    type: File
    doc: set the output Rdata file
    outputBinding:
      glob: $(inputs.rdata_output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: 
      biocontainers/batchcorrection:phenomenal-vphenomenal_2017.12.14_cv0.3.3
