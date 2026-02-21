cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-chopfalines
label: ucsc-chopfalines
doc: "The provided text contains error messages related to the container environment
  and image fetching rather than the tool's help documentation. As a result, no usage
  information or arguments could be extracted.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-chopfalines:482--h0b57e2e_0
stdout: ucsc-chopfalines.out
