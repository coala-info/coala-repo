cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHubStop
label: ucsc-paranodestop_paraHubStop
doc: "A tool to stop a UCSC Parasol hub. Note: The provided help text contains only
  container runtime error messages and no usage information.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestop:482--h0b57e2e_0
stdout: ucsc-paranodestop_paraHubStop.out
