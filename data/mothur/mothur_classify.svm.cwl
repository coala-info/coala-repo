cwlVersion: v1.2
class: CommandLineTool
baseCommand: mothur
label: mothur_classify.svm
doc: "Classifies sequences using the SVM algorithm.\n\nTool homepage: https://www.mothur.org"
inputs:
  - id: batch_file
    type: File
    doc: The batch file containing commands for classification.
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mothur:1.48.5--h11ba690_0
stdout: mothur_classify.svm.out
