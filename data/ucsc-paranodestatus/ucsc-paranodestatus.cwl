cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStatus
label: ucsc-paranodestatus
doc: "A UCSC Genome Browser utility to check the status of nodes in a cluster. (Note:
  The provided text was a container build error log and did not contain usage information.)\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-paranodestatus:482--h0b57e2e_0
stdout: ucsc-paranodestatus.out
