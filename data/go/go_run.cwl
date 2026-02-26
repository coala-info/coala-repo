cwlVersion: v1.2
class: CommandLineTool
baseCommand: go run
label: go_run
doc: "Run a Go program\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: build_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: Build flags for the Go program
    inputBinding:
      position: 1
  - id: package
    type: string
    doc: The Go package to run
    inputBinding:
      position: 2
  - id: arguments
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments to pass to the Go program
    inputBinding:
      position: 3
  - id: exec_prog
    type:
      - 'null'
      - string
    doc: Execute a specific program
    inputBinding:
      position: 104
      prefix: -exec
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_run.out
