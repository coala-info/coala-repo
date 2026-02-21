cwlVersion: v1.2
class: CommandLineTool
baseCommand: go
label: go
doc: "The Go programming language tool (Note: The provided text contains error logs
  and environment information rather than command-line help documentation).\n\nTool
  homepage: https://github.com/avelino/awesome-go"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go.out
