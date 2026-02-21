cwlVersion: v1.2
class: CommandLineTool
baseCommand: randomLines
label: ucsc-randomlines
doc: "The provided text contains error logs from a container runtime failure and does
  not include the help documentation for the tool. As a result, no arguments could
  be extracted.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-randomlines:482--h0b57e2e_0
stdout: ucsc-randomlines.out
