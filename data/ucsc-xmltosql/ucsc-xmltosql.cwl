cwlVersion: v1.2
class: CommandLineTool
baseCommand: xmlToSql
label: ucsc-xmltosql
doc: "A tool to convert XML files to SQL format, typically used in the context of
  UCSC Genome Browser data processing.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-xmltosql:482--h0b57e2e_0
stdout: ucsc-xmltosql.out
