cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-fatrans
label: ucsc-fatrans
doc: "The provided text does not contain help information for the tool. It contains
  container runtime logs and a fatal error message indicating a failure to fetch or
  build the image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-fatrans:482--h0b57e2e_0
stdout: ucsc-fatrans.out
