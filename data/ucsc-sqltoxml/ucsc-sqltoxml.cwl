cwlVersion: v1.2
class: CommandLineTool
baseCommand: sqlToXml
label: ucsc-sqltoxml
doc: "A tool to convert SQL data to XML format. (Note: The provided help text contained
  only system error messages and did not list specific arguments.)\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-sqltoxml:482--h0b57e2e_0
stdout: ucsc-sqltoxml.out
