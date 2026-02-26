cwlVersion: v1.2
class: CommandLineTool
baseCommand: go
label: go_vet
doc: "Go is a tool for managing Go source code.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: command
    type: string
    doc: The command to execute (e.g., build, test, vet)
    inputBinding:
      position: 1
  - id: arguments
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
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_vet.out
