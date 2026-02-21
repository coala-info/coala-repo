cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair_callVarBam.py
label: clair_callVarBam.py
doc: "Clair: a germline variant caller using deep learning. (Note: The provided help
  text contains a system error log regarding container build failure and does not
  list command-line arguments.)\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdout: clair_callVarBam.py.out
