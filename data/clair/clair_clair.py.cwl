cwlVersion: v1.2
class: CommandLineTool
baseCommand: clair_clair.py
label: clair_clair.py
doc: "Clair (v2.1.1): A germline variant caller for long-read sequencing. (Note: The
  provided text is a container execution error log and does not contain help documentation
  or argument definitions.)\n\nTool homepage: https://github.com/HKU-BAL/Clair"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clair:2.1.1--hdfd78af_1
stdout: clair_clair.py.out
