cwlVersion: v1.2
class: CommandLineTool
baseCommand: counterr
label: counterr
doc: "A tool for counting errors in sequencing data (Note: The provided text appears
  to be a container build error log rather than help text, so no arguments could be
  extracted).\n\nTool homepage: https://github.com/dayzerodx/counterr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/counterr:0.1--py_0
stdout: counterr.out
