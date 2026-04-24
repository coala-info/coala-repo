cwlVersion: v1.2
class: CommandLineTool
baseCommand: svm_classify
label: svmlight_svm_classify
doc: "SVM-light V6.02: Support Vector Machine, classification module\n\nTool homepage:
  http://svmlight.joachims.org/"
inputs:
  - id: example_file
    type: File
    doc: File containing the examples to classify
    inputBinding:
      position: 1
  - id: model_file
    type: File
    doc: File containing the trained SVM model
    inputBinding:
      position: 2
  - id: output_format
    type:
      - 'null'
      - int
    doc: '0: old output format of V1.0, 1: output the value of decision function (default)'
    inputBinding:
      position: 103
      prefix: -f
  - id: verbosity_level
    type:
      - 'null'
      - int
    doc: verbosity level (default 2)
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: File to write the classification results to
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
