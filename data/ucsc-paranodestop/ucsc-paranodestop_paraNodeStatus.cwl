cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStatus
label: ucsc-paranodestop_paraNodeStatus
doc: "The provided text does not contain help information for the tool, as it reports
  a fatal error during the container image build process.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestop:482--h0b57e2e_0
stdout: ucsc-paranodestop_paraNodeStatus.out
