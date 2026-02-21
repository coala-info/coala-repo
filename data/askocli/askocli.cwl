cwlVersion: v1.2
class: CommandLineTool
baseCommand: askocli
label: askocli
doc: "A command-line interface tool for askocli.\n\nTool homepage: https://github.com/askomics/askocli"
inputs:
  - id: command
    type: string
    doc: The command to execute
    inputBinding:
      position: 1
  - id: args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the specified command
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/askocli:0.5--py_0
stdout: askocli.out
