cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgBbidblink
label: ucsc-hgbbidblink
doc: "A tool from the UCSC Genome Browser suite. (Note: The provided help text contains
  container runtime errors and does not list specific usage or arguments.)\n\nTool
  homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgbbidblink:482--h0b57e2e_0
stdout: ucsc-hgbbidblink.out
