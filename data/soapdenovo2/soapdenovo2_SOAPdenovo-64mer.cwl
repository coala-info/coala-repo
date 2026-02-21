cwlVersion: v1.2
class: CommandLineTool
baseCommand: SOAPdenovo-64mer
label: soapdenovo2_SOAPdenovo-64mer
doc: "SOAPdenovo is a short-read assembly method for de novo genome assembly. (Note:
  The provided input text contains system error logs rather than tool help text; therefore,
  no arguments could be extracted.)\n\nTool homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2:2.40--1
stdout: soapdenovo2_SOAPdenovo-64mer.out
