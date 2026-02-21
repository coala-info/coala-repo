cwlVersion: v1.2
class: CommandLineTool
baseCommand: ucsc-hgtrackdb
label: ucsc-hgtrackdb
doc: "The provided text does not contain help information for the tool; it is a log
  of a container build failure.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgtrackdb:482--h0b57e2e_0
stdout: ucsc-hgtrackdb.out
