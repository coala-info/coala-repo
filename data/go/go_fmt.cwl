cwlVersion: v1.2
class: CommandLineTool
baseCommand: go fmt
label: go_fmt
doc: "Format Go programs\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Packages to format
    inputBinding:
      position: 1
  - id: print_commands
    type:
      - 'null'
      - boolean
    doc: Print the names of updated files
    inputBinding:
      position: 102
      prefix: -n
  - id: print_execution
    type:
      - 'null'
      - boolean
    doc: Print commands as they are executed
    inputBinding:
      position: 102
      prefix: -x
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_fmt.out
