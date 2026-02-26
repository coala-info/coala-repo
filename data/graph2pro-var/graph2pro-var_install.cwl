cwlVersion: v1.2
class: CommandLineTool
baseCommand: install
label: graph2pro-var_install
doc: "Copy files and set attributes\n\nTool homepage: https://github.com/COL-IU/graph2pro-var"
inputs:
  - id: source_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Source files to copy
    inputBinding:
      position: 1
  - id: destination
    type: Directory
    doc: Destination directory
    inputBinding:
      position: 2
  - id: copy_only
    type:
      - 'null'
      - boolean
    doc: Just copy (default)
    default: true
    inputBinding:
      position: 103
      prefix: -c
  - id: create_directories
    type:
      - 'null'
      - boolean
    doc: Create directories
    inputBinding:
      position: 103
      prefix: -d
  - id: create_leading_directories
    type:
      - 'null'
      - boolean
    doc: Create leading target directories
    inputBinding:
      position: 103
      prefix: -D
  - id: group
    type:
      - 'null'
      - string
    doc: Set group ownership
    inputBinding:
      position: 103
      prefix: -g
  - id: owner
    type:
      - 'null'
      - string
    doc: Set ownership
    inputBinding:
      position: 103
      prefix: -o
  - id: permissions
    type:
      - 'null'
      - string
    doc: Set permissions
    inputBinding:
      position: 103
      prefix: -m
  - id: preserve_date
    type:
      - 'null'
      - boolean
    doc: Preserve date
    inputBinding:
      position: 103
      prefix: -p
  - id: strip_symbol_table
    type:
      - 'null'
      - boolean
    doc: Strip symbol table
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graph2pro-var:1.0.0--0
stdout: graph2pro-var_install.out
