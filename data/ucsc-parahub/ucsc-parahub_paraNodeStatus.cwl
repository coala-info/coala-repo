cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStatus
label: ucsc-parahub_paraNodeStatus
doc: "A tool to check the status of nodes in a paraHub cluster. Note: The provided
  help text contains only system logs and error messages, so no specific arguments
  could be extracted.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_paraNodeStatus.out
