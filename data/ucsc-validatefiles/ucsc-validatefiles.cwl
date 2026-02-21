cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-validatefiles
label: ucsc-validatefiles
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime error logs indicating a failure to fetch
  or build the image.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-validatefiles:482--h0b57e2e_0
stdout: ucsc-validatefiles.out
