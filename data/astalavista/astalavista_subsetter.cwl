cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - subsetter
label: astalavista_subsetter
doc: "Extract a random subset of lines from a file\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
inputs:
  - id: force
    type:
      - 'null'
      - boolean
    doc: Disable interactivity. No questions will be asked
    inputBinding:
      position: 101
      prefix: --force
  - id: list_tools
    type:
      - 'null'
      - boolean
    doc: List available tools
    inputBinding:
      position: 101
      prefix: --list-tools
  - id: log
    type:
      - 'null'
      - string
    doc: Log level (NONE|INFO|ERROR|DEBUG)
    inputBinding:
      position: 101
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
stdout: astalavista_subsetter.out
