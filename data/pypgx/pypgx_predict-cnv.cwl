cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx predict-cnv
label: pypgx_predict-cnv
doc: "Predict CNV from copy number data for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: copy_number
    type: File
    doc: Input archive file with the semantic type CovFrame[CopyNumber].
    inputBinding:
      position: 1
  - id: cnv_caller
    type:
      - 'null'
      - File
    doc: Archive file with the semantic type Model[CNV]. By default, a 
      pre-trained CNV caller in the pypgx-bundle directory will be used.
    inputBinding:
      position: 102
      prefix: --cnv-caller
outputs:
  - id: cnv_calls
    type: File
    doc: Output archive file with the semantic type SampleTable[CNVCalls].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
