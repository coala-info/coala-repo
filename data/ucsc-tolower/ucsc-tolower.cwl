cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-tolower
label: ucsc-tolower
doc: "The provided text does not contain help information for the tool, but appears
  to be a container execution error log.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-tolower:482--h0b57e2e_0
stdout: ucsc-tolower.out
