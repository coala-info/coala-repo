cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - Rscript
  - /files/batch_correction/batch_correction_docker_wrapper.R
label: batchcorrection_batch_correction_all_loess_wrapper.r
doc: "Wrapper script for batch correction, with options to use LOESS or other methods.\n\
  \nTool homepage: https://github.com/workflow4metabolomics/batch_correction"
arguments:
  - position: 0
    valueFrom: --loess
  - position: 0
    valueFrom: "TRUE"
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
  - id: method
    type: string
    doc: Set the method; can set to "all_loess_pool" or "all_loess_sample"
    inputBinding:
      position: 4
      prefix: method
  - id: span
    type: string
    doc: Set the span condition (for example 1)
    inputBinding:
      position: 5
      prefix: span
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
    dockerPull: 
      biocontainers/batchcorrection:phenomenal-vphenomenal_2017.12.14_cv0.3.3
