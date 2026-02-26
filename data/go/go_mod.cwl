cwlVersion: v1.2
class: CommandLineTool
baseCommand: go mod
label: go_mod
doc: "Provides access to operations on modules.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: command
    type: string
    doc: The command to run (e.g., download, edit, graph, init, tidy, vendor, 
      verify, why)
    inputBinding:
      position: 1
  - id: arguments
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
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_mod.out
