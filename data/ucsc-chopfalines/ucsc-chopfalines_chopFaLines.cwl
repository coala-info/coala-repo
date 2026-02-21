cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - chopFaLines
label: ucsc-chopfalines_chopFaLines
doc: "A tool to chop FASTA lines to a specific length. Note: The provided help text
  contains only system error messages and does not list usage or arguments.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chopfalines:482--h0b57e2e_0
stdout: ucsc-chopfalines_chopFaLines.out
