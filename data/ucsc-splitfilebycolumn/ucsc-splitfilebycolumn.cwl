cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-splitfilebycolumn
label: ucsc-splitfilebycolumn
doc: "Split a file into multiple files based on the values in a specific column.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-splitfilebycolumn:482--h0b57e2e_0
stdout: ucsc-splitfilebycolumn.out
