cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini browser
label: gemini_browser
doc: "Launch the Gemini browser\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: host
    type:
      - 'null'
      - string
    doc: 'Hostname, default: localhost.'
    inputBinding:
      position: 102
      prefix: --host
  - id: port
    type:
      - 'null'
      - int
    doc: 'Port, default: 8088.'
    inputBinding:
      position: 102
      prefix: --port
  - id: use
    type:
      - 'null'
      - string
    doc: 'Which browser to use: builtin or puzzle'
    inputBinding:
      position: 102
      prefix: --use
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_browser.out
