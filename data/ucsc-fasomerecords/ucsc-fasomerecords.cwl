cwlVersion: v1.2
class: CommandLineTool
baseCommand: faSomeRecords
label: ucsc-fasomerecords
doc: "Extract multiple fa records from a fasta file using a list of record names.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fasomerecords:482--h0b57e2e_0
stdout: ucsc-fasomerecords.out
