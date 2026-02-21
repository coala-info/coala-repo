cwlVersion: v1.2
class: CommandLineTool
baseCommand: subChar
label: ucsc-subchar
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-subchar:482--h0b57e2e_0
stdout: ucsc-subchar.out
