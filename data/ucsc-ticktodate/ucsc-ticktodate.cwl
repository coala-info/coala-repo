cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-ticktodate
label: ucsc-ticktodate
doc: "The provided text does not contain help information for the tool. It contains
  system logs and a fatal error message regarding a container build failure.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-ticktodate:482--h0b57e2e_0
stdout: ucsc-ticktodate.out
