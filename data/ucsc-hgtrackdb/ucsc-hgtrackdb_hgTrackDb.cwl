cwlVersion: v1.2
class: CommandLineTool
baseCommand: hgTrackDb
label: ucsc-hgtrackdb_hgTrackDb
doc: "The provided text contains error logs related to a container build process and
  does not include the help documentation or usage instructions for the tool 'hgTrackDb'.\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-hgtrackdb:482--h0b57e2e_0
stdout: ucsc-hgtrackdb_hgTrackDb.out
