cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHubStop
label: ucsc-para_paraHubStop
doc: "A tool to stop a paraHub process, part of the UCSC para suite.\n\nTool homepage:
  http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-para:469--h664eb37_1
stdout: ucsc-para_paraHubStop.out
