cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHubStop
label: ucsc-parahubstop_paraHubStop
doc: "Shut down paraHub daemon.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs:
  - id: now
    type: string
    doc: Shut down paraHub daemon immediately
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahubstop:482--h0b57e2e_0
stdout: ucsc-parahubstop_paraHubStop.out
