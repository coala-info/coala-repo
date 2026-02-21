cwlVersion: v1.2
class: CommandLineTool
baseCommand: getRNA
label: ucsc-getrna
doc: "A tool from the UCSC Genome Browser toolset. Note: The provided help text contains
  only container execution errors and does not list usage or arguments.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-getrna:482--h0b57e2e_0
stdout: ucsc-getrna.out
