cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoSql
label: ucsc-autosql
doc: "The provided text does not contain help information; it is an error log indicating
  a failure to build or run the container due to insufficient disk space. Based on
  the tool name hint, this tool (autoSql) is typically used to create C code and SQL
  commands from an autoSql specification file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autosql:482--h0b57e2e_0
stdout: ucsc-autosql.out
