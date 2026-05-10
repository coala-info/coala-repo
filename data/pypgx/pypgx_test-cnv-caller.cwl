cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pypgx
  - test-cnv-caller
label: pypgx_test-cnv-caller
doc: "Test CNV caller for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: cnv_caller
    type: File
    doc: Input archive file with the semantic type Model[CNV].
    inputBinding:
      position: 1
  - id: copy_number
    type: File
    doc: Input archive file with the semantic type CovFrame[CopyNumber].
    inputBinding:
      position: 2
  - id: cnv_calls
    type: File
    doc: Input archive file with the semantic type SampleTable[CNVCalls].
    inputBinding:
      position: 3
  - id: comparison_table_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `comparison_table_path`
    inputBinding:
      position: 101
      prefix: --comparison-table
  - id: confusion_matrix_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `confusion_matrix_path`
    inputBinding:
      position: 102
      prefix: --confusion-matrix
outputs:
  - id: confusion_matrix
    type:
      - 'null'
      - File
    doc: Write the confusion matrix as a CSV file where rows indicate actual 
      class and columns indicate prediction class.
    outputBinding:
      glob: $(inputs.confusion_matrix_path)
  - id: comparison_table
    type:
      - 'null'
      - File
    doc: Write a CSV file comparing actual vs. predicted CNV calls for each 
      sample.
    outputBinding:
      glob: $(inputs.comparison_table_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
