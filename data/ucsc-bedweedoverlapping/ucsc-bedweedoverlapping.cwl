cwlVersion: v1.2
class: CommandLineTool
baseCommand: bedWeedOverlapping
label: ucsc-bedweedoverlapping
doc: "The provided text does not contain help information for the tool. It is a system
  error log indicating a failure to build or extract the container image due to insufficient
  disk space ('no space left on device').\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bedweedoverlapping:482--h0b57e2e_0
stdout: ucsc-bedweedoverlapping.out
