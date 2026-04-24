cwlVersion: v1.2
class: CommandLineTool
baseCommand: crunchstat-summary
label: crunchstat-summary
doc: "Summarize Arvados crunchstat logs\n\nTool homepage: https://arvados.org"
inputs:
  - id: format
    type:
      - 'null'
      - string
    doc: Output format (text, html, json)
    inputBinding:
      position: 101
      prefix: --format
  - id: logfile
    type:
      - 'null'
      - File
    doc: 'Read stats from LOGFILE (default: stdin)'
    inputBinding:
      position: 101
      prefix: --logfile
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: 'Write output to OUT (default: stdout)'
    outputBinding:
      glob: $(inputs.out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crunchstat-summary:3.2.0--pyhdfd78af_0
