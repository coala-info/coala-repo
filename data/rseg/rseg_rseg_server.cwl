cwlVersion: v1.2
class: CommandLineTool
baseCommand: rseg-server
label: rseg_rseg_server
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build/fetch process.\n\nTool homepage: https://github.com/yzhang/rseg"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseg:0.4.9--he941832_1
stdout: rseg_rseg_server.out
