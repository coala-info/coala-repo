cwlVersion: v1.2
class: CommandLineTool
baseCommand: survindel2_train_classifier.py
label: survindel2_train_classifier.py
doc: "Train classifier for SurvinDel2 (Note: The provided text contains container
  runtime error logs rather than tool help text; no arguments could be extracted).\n
  \nTool homepage: https://github.com/kensung-lab/SurVIndel2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/survindel2:1.1.4--h503566f_0
stdout: survindel2_train_classifier.py.out
