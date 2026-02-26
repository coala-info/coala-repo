cwlVersion: v1.2
class: CommandLineTool
baseCommand: varda2-client monitor
label: varda2-client_monitor
doc: "Monitor tasks\n\nTool homepage: https://github.com/varda/varda2-client"
inputs:
  - id: tasks_fn
    type: File
    doc: Filename of tasks to monitor
    inputBinding:
      position: 101
      prefix: --task-file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client_monitor.out
