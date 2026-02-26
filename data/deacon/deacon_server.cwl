cwlVersion: v1.2
class: CommandLineTool
baseCommand: deacon server
label: deacon_server
doc: "Start/stop a server process for reduced latency filtering\n\nTool homepage:
  https://github.com/bede/deacon"
inputs:
  - id: command
    type: string
    doc: Command to execute (start, stop, help)
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deacon:0.13.2--h7ef3eeb_1
stdout: deacon_server.out
