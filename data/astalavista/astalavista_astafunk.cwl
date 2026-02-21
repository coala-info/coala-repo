cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - astalavista
  - -t
  - astafunk
label: astalavista_astafunk
doc: "Alternative Splicing Transcriptional Analyses with Functional Knowledge: Search
  Pfam HMMs against alternatively spliced regions.\n\nTool homepage: https://github.com/divyavewall/astalavista-frontend"
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
    default: INFO
    inputBinding:
      position: 101
      prefix: --log
  - id: threads
    type:
      - 'null'
      - int
    doc: Maximum number of threads to use.
    default: 2
    inputBinding:
      position: 101
      prefix: --threads
  - id: tool
    type:
      - 'null'
      - string
    doc: Select a tool
    default: astalavista
    inputBinding:
      position: 101
      prefix: --tool
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/astalavista:4.0--0
stdout: astalavista_astafunk.out
