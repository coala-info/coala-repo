cwlVersion: v1.2
class: CommandLineTool
baseCommand: erne_create_infer_task.py
label: erne_create_infer_task.py
doc: "A tool for creating inference tasks (Note: The provided help text contains only
  system error messages and does not list specific tool arguments).\n\nTool homepage:
  https://github.com/chengyuanba/avatar_ernerf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/erne:2.1.1--boost1.61_0
stdout: erne_create_infer_task.py.out
