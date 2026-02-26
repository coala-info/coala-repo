cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - graphtyper
  - call
label: graphtyper_call
doc: "Call variants of a graph.\n\nTool homepage: https://github.com/DecodeGenetics/graphtyper"
inputs:
  - id: log_file
    type:
      - 'null'
      - File
    doc: Set path to log file.
    inputBinding:
      position: 101
      prefix: --log
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Set to output verbose logging.
    inputBinding:
      position: 101
      prefix: --verbose
  - id: vverbose
    type:
      - 'null'
      - boolean
    doc: Set to output very verbose logging.
    inputBinding:
      position: 101
      prefix: --vverbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphtyper:2.7.7--h7594796_1
stdout: graphtyper_call.out
