cwlVersion: v1.2
class: CommandLineTool
baseCommand: qaToQa
label: ucsc-qactoqa
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-qactoqa:482--h0b57e2e_0
stdout: ucsc-qactoqa.out
