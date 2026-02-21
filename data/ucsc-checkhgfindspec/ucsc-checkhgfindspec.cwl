cwlVersion: v1.2
class: CommandLineTool
baseCommand: checkHgFindSpec
label: ucsc-checkhgfindspec
doc: "A tool to check hgFindSpec tables for consistency. (Note: The provided help
  text contained only container execution errors and did not list specific arguments.)\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-checkhgfindspec:482--h0b57e2e_0
stdout: ucsc-checkhgfindspec.out
