cwlVersion: v1.2
class: CommandLineTool
baseCommand: dbTrash
label: ucsc-dbtrash_dbTrash
doc: "A tool from the UCSC Genome Browser suite used to clean up temporary tables
  in a database. Note: The provided help text contains only container execution errors
  and does not list specific arguments.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-dbtrash:482--h0b57e2e_0
stdout: ucsc-dbtrash_dbTrash.out
