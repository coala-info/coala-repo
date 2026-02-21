cwlVersion: v1.2
class: CommandLineTool
baseCommand: paraHubStop
label: ucsc-parahub_paraHubStop
doc: "A tool to stop a ParaHub cluster. (Note: The provided help text contains only
  container runtime error logs and does not list specific command-line arguments.)\n
  \nTool homepage: http://hgdownload.cse.ucsc.edu/admin/exe/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-parahub:469--h664eb37_1
stdout: ucsc-parahub_paraHubStop.out
