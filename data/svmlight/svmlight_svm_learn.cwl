cwlVersion: v1.2
class: CommandLineTool
baseCommand: svm_learn
label: svmlight_svm_learn
doc: "SVM-light learning module. (Note: The provided input text contains container
  runtime errors and does not include the tool's help documentation.)\n\nTool homepage:
  http://svmlight.joachims.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
stdout: svmlight_svm_learn.out
