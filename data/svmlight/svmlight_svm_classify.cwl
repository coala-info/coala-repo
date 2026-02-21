cwlVersion: v1.2
class: CommandLineTool
baseCommand: svm_classify
label: svmlight_svm_classify
doc: "The provided text does not contain help information for the tool; it contains
  container runtime error logs indicating a failure to fetch or build the OCI image.\n
  \nTool homepage: http://svmlight.joachims.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svmlight:6.02--h7b50bb2_8
stdout: svmlight_svm_classify.out
