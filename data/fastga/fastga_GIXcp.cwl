cwlVersion: v1.2
class: CommandLineTool
baseCommand: GIXcp
label: fastga_GIXcp
doc: "Copies GIX database files, with options for verbosity, prompting, and overwriting.\n\
  \nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source
    type: File
    doc: Source GIX database file path (e.g., .1gdb or .gix)
    inputBinding:
      position: 1
  - id: target
    type: File
    doc: Target GIX database file path (e.g., .1gdb or .gix)
    inputBinding:
      position: 2
  - id: force_quiet
    type:
      - 'null'
      - boolean
    doc: Force operation quietly.
    inputBinding:
      position: 103
      prefix: -f
  - id: interactive
    type:
      - 'null'
      - boolean
    doc: Prompt for each deletion.
    inputBinding:
      position: 103
      prefix: -i
  - id: no_overwrite
    type:
      - 'null'
      - boolean
    doc: Do not overwrite existing files.
    inputBinding:
      position: 103
      prefix: -n
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode, list what is being deleted.
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GIXcp.out
