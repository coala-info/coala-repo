cwlVersion: v1.2
class: CommandLineTool
baseCommand: list
label: qax_list
doc: "List artifacts\n\nTool homepage: https://github.com/telatin/qax"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Input files to list
    inputBinding:
      position: 1
  - id: absolute_paths
    type:
      - 'null'
      - boolean
    doc: Show absolute paths
    inputBinding:
      position: 102
      prefix: --abs
  - id: basename
    type:
      - 'null'
      - boolean
    doc: Use basename instead of path
    inputBinding:
      position: 102
      prefix: --basename
  - id: force
    type:
      - 'null'
      - boolean
    doc: Accept non standard extensions
    inputBinding:
      position: 102
      prefix: --force
  - id: header
    type:
      - 'null'
      - boolean
    doc: Print header
    inputBinding:
      position: 102
      prefix: --header
  - id: rawtable
    type:
      - 'null'
      - boolean
    doc: Print a CSV table (-s) with all fields
    inputBinding:
      position: 102
      prefix: --rawtable
  - id: separator
    type:
      - 'null'
      - string
    doc: Separator when using --rawtable
    inputBinding:
      position: 102
      prefix: --separator
  - id: show_all_fields
    type:
      - 'null'
      - boolean
    doc: Show all fields
    inputBinding:
      position: 102
      prefix: --all
  - id: show_datetime
    type:
      - 'null'
      - boolean
    doc: Show artifact's date time
    inputBinding:
      position: 102
      prefix: --datetime
  - id: show_uuid
    type:
      - 'null'
      - boolean
    doc: Show uuid
    inputBinding:
      position: 102
      prefix: --uuid
  - id: sortby
    type:
      - 'null'
      - string
    doc: Column to sort (uuid, type, format, date)
    inputBinding:
      position: 102
      prefix: --sortby
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 102
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qax:0.9.8--h515fd9b_0
stdout: qax_list.out
