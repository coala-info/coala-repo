cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraNodeStatus
label: ucsc-para_paraNodeStatus
doc: "The provided text does not contain help information for the tool. It appears
  to be a container runtime error log.\n\nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_paraNodeStatus.out
