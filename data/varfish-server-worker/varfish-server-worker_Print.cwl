cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-server-worker
label: varfish-server-worker_Print
doc: "varfish-server-worker\n\nTool homepage: https://github.com/bihealth/varfish-server-worker"
inputs:
  - id: command
    type: string
    doc: Command to execute
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
stdout: varfish-server-worker_Print.out
