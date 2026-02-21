cwlVersion: v1.2
class: CommandLineTool
baseCommand: raSqlQuery
label: ucsc-rasqlquery
doc: "A tool to execute SQL-like queries on .ra files. (Note: The provided help text
  contains container execution errors and does not list specific arguments.)\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rasqlquery:482--h0b57e2e_0
stdout: ucsc-rasqlquery.out
