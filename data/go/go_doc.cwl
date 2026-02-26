cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - go
  - doc
label: go_doc
doc: "Display documentation for Go packages and symbols.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: package
    type:
      - 'null'
      - string
    doc: The package to document.
    inputBinding:
      position: 1
  - id: symbol
    type:
      - 'null'
      - string
    doc: The symbol (function, type, variable, etc.) to document within the 
      package.
    inputBinding:
      position: 2
  - id: case_sensitive
    type:
      - 'null'
      - boolean
    doc: Symbol matching honors case (paths not affected).
    inputBinding:
      position: 103
      prefix: -c
  - id: show_command_packages
    type:
      - 'null'
      - boolean
    doc: Show symbols with package docs even if package is a command.
    inputBinding:
      position: 103
      prefix: --cmd
  - id: show_unexported
    type:
      - 'null'
      - boolean
    doc: Show unexported symbols as well as exported.
    inputBinding:
      position: 103
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_doc.out
