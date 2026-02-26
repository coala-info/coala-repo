cwlVersion: v1.2
class: CommandLineTool
baseCommand: varda2-client task
label: varda2-client_task
doc: "\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: uuid
    type: string
    doc: Task UUID
    inputBinding:
      position: 101
      prefix: --uuid
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_task.out
