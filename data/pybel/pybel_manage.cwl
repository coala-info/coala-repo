cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pybel
  - manage
label: pybel_manage
doc: "Manage the database.\n\nTool homepage: https://pybel.readthedocs.io"
inputs:
  - id: command
    type: string
    doc: The command to run
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybel:0.13.2--py_0
stdout: pybel_manage.out
