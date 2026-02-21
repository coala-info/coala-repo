cwlVersion: v1.2
class: CommandLineTool
baseCommand: getRNApred
label: ucsc-getrnapred
doc: "A tool from the UCSC Genome Browser utilities to get RNA predictions.\n\nTool
  homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-getrnapred:482--h0b57e2e_0
stdout: ucsc-getrnapred.out
