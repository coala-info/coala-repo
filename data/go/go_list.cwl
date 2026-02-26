cwlVersion: v1.2
class: CommandLineTool
baseCommand: go list
label: go_list
doc: "List packages or modules\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: list_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: list flags
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
  - id: format
    type:
      - 'null'
      - string
    doc: format string
    inputBinding:
      position: 104
      prefix: -f
  - id: json
    type:
      - 'null'
      - boolean
    doc: output in JSON format
    inputBinding:
      position: 104
      prefix: -json
  - id: m
    type:
      - 'null'
      - boolean
    doc: list module information
    inputBinding:
      position: 104
      prefix: -m
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_list.out
