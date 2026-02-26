cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - go
  - fix
label: go_fix
doc: "Run 'go help fix' for details.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: Packages to fix
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_fix.out
