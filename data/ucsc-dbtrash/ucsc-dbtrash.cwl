cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-dbtrash
label: ucsc-dbtrash
doc: "A UCSC Genome Browser utility to clean up old tables from a database. (Note:
  The provided help text contains container runtime error messages and does not list
  specific command-line arguments.)\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-dbtrash:482--h0b57e2e_0
stdout: ucsc-dbtrash.out
