cwlVersion: v1.2
class: CommandLineTool
baseCommand: splitFileByColumn
label: ucsc-splitfilebycolumn_splitFileByColumn
doc: "Split a file by a column. (Note: The provided text contains container build
  errors and does not include usage information or argument definitions.)\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-splitfilebycolumn:482--h0b57e2e_0
stdout: ucsc-splitfilebycolumn_splitFileByColumn.out
