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
  - id: out_path
    type: string
    doc: Output or path parameter `out_path`
    inputBinding:
      position: 102
      prefix: --out
outputs:
  - id: out
    type:
      - 'null'
      - File
    doc: 'Write output to OUT (default: stdout)'
    outputBinding:
      glob: $(inputs.out_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crunchstat-summary:3.2.0--pyhdfd78af_0
