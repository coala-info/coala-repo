cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdfkit
label: pdfkit
doc: "The provided text does not contain help documentation for pdfkit; it is a log
  of a failed execution indicating the executable was not found.\n\nTool homepage:
  https://pypi.python.org/pypi/pdfkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdfkit:0.6.1--py35_0
stdout: pdfkit.out
