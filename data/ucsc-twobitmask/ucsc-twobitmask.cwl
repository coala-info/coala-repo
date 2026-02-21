cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-twobitmask
label: ucsc-twobitmask
doc: "The provided text does not contain help information for the tool; it is a log
  of a fatal error encountered while attempting to fetch or build the container image.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitmask:482--h0b57e2e_0
stdout: ucsc-twobitmask.out
