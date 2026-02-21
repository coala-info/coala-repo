cwlVersion: v1.2
class: CommandLineTool
baseCommand: erne_create_train_task.py
label: erne_create_train_task.py
doc: "erne_create_train_task.py\n\nTool homepage: https://github.com/chengyuanba/avatar_ernerf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/erne:2.1.1--boost1.61_0
stdout: erne_create_train_task.py.out
