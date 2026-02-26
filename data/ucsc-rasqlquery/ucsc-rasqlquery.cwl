cwlVersion: v1.2
class: CommandLineTool
baseCommand: raSqlQuery
label: ucsc-rasqlquery
doc: "Execute a SQL-like query on a .ra file. Note: The provided input text was a
  Docker error message and did not contain the help documentation; arguments are based
  on standard tool usage.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: ra_file
    type: File
    doc: The .ra file to query
    inputBinding:
      position: 1
  - id: query
    type: string
    doc: The SQL-like query to execute
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-rasqlquery:482--h0b57e2e_0
stdout: ucsc-rasqlquery.out
