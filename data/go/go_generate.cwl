cwlVersion: v1.2
class: CommandLineTool
baseCommand: go generate
label: go_generate
doc: "Run 'go help generate' for details.\n\nTool homepage: https://github.com/avelino/awesome-go"
inputs:
  - id: build_flags
    type:
      - 'null'
      - type: array
        items: string
    doc: build flags
    inputBinding:
      position: 1
  - id: files_or_packages
    type:
      - 'null'
      - type: array
        items: string
    doc: file.go... | packages
    inputBinding:
      position: 2
  - id: print_and_run
    type:
      - 'null'
      - boolean
    doc: print the commands as they are executed
    inputBinding:
      position: 103
      prefix: -x
  - id: print_commands
    type:
      - 'null'
      - boolean
    doc: print the commands that would be executed
    inputBinding:
      position: 103
      prefix: -n
  - id: run
    type:
      - 'null'
      - string
    doc: regexp specifies a list of packages to build, run, or test. If the list
      is not empty, only packages matching the regular expression will be acted 
      upon.
    inputBinding:
      position: 103
      prefix: -run
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: print the names of packages as they are built
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go:1.11.3
stdout: go_generate.out
