cwlVersion: v1.2
class: CommandLineTool
baseCommand: varfish-server-worker
label: varfish-server-worker
doc: "VarFish server worker\n\nTool homepage: https://github.com/bihealth/varfish-server-worker"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varfish-server-worker:0.17.3--h13c227e_0
stdout: varfish-server-worker.out
