cwlVersion: v1.2
class: CommandLineTool
baseCommand: soapdenovo2_sparse_pregraph
label: soapdenovo2_sparse_pregraph
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container image retrieval.\n\nTool homepage: https://github.com/aquaskyline/SOAPdenovo2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/soapdenovo2:2.40--1
stdout: soapdenovo2_sparse_pregraph.out
