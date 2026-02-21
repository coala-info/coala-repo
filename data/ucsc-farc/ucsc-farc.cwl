cwlVersion: v1.2
class: CommandLineTool
baseCommand: farc
label: ucsc-farc
doc: "The provided text does not contain help information for the tool; it is a log
  of a container execution failure. No arguments or usage information could be extracted.\n
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-farc:482--h0b57e2e_0
stdout: ucsc-farc.out
