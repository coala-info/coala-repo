cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - check
label: graphtyper_check
doc: "Check a GraphTyper graph (useful for debugging).\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: graph
    type: File
    doc: Path to graph.
    inputBinding:
      position: 1
  - id: log
    type:
      - 'null'
      - string
    doc: Set path to log file.
    inputBinding:
      position: 102
      prefix: --log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 102
      prefix: --verbose
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 102
      prefix: --vverbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_check.out
