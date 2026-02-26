cwlVersion: v1.2
class: CommandLineTool
baseCommand: tar
label: blinker_tar
doc: "Create, extract, or list files from a tar file\n\nTool homepage: https://github.com/blinksh/blink"
inputs:
  - id: files
    type:
      - 'null'
      - type: array
        items: File
    doc: Files to operate on
    inputBinding:
      position: 1
  - id: change_directory
    type:
      - 'null'
      - Directory
    doc: Change to DIR before operation
    inputBinding:
      position: 102
      prefix: -C
  - id: create
    type:
      - 'null'
      - boolean
    doc: Create
    inputBinding:
      position: 102
      prefix: -c
  - id: exclude_file
    type:
      - 'null'
      - File
    doc: File to exclude
    inputBinding:
      position: 102
  - id: exclude_from_file
    type:
      - 'null'
      - File
    doc: File with names to exclude
    inputBinding:
      position: 102
      prefix: -X
  - id: extract
    type:
      - 'null'
      - boolean
    doc: Extract
    inputBinding:
      position: 102
      prefix: -x
  - id: extract_to_stdout
    type:
      - 'null'
      - boolean
    doc: Extract to stdout
    inputBinding:
      position: 102
      prefix: -O
  - id: follow_symlinks
    type:
      - 'null'
      - boolean
    doc: Follow symlinks
    inputBinding:
      position: 102
      prefix: -h
  - id: include_from_file
    type:
      - 'null'
      - File
    doc: File with names to include
    inputBinding:
      position: 102
      prefix: -T
  - id: list
    type:
      - 'null'
      - boolean
    doc: List
    inputBinding:
      position: 102
      prefix: -t
  - id: tar_file
    type:
      - 'null'
      - File
    doc: Name of TARFILE ('-' for stdin/out)
    inputBinding:
      position: 102
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blinker:1.4--py35_0
stdout: blinker_tar.out
