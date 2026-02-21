cwlVersion: v1.2
class: CommandLineTool
baseCommand: findMotif
label: ucsc-findmotif
doc: "The provided text is a container execution error log and does not contain help
  information or usage instructions for the tool 'ucsc-findmotif'.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-findmotif:482--h0b57e2e_0
stdout: ucsc-findmotif.out
