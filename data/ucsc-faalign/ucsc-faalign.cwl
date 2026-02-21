cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-faalign
label: ucsc-faalign
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-faalign:482--h0b57e2e_0
stdout: ucsc-faalign.out
