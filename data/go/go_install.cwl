cwlVersion: v1.2
class: CommandLineTool
baseCommand: go install
label: go_install
doc: "Install packages and dependencies\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: build_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: build flags
    inputBinding:
      position: 1
  - id: packages
    type:
      - 'null'
      - type: array
        items: string
    doc: packages to install
    inputBinding:
      position: 2
  - id: install_dependencies
    type:
      - 'null'
      - boolean
    doc: install dependencies even if they are already installed
    inputBinding:
      position: 103
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_install.out
