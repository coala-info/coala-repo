cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - go
  - clean
label: go_clean
doc: "Run 'go help clean' for details.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: clean_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: clean flags
    inputBinding:
      position: 1
  - id: build_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: build flags
    inputBinding:
      position: 2
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: packages
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_clean.out
