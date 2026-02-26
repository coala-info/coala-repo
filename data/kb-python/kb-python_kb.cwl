cwlVersion: v1.2
class: CommandLineTool
baseCommand: kb
label: kb-python_kb
doc: "kb_python 0.30.0\n\nTool homepage: https://github.com/pachterlab/kb_python"
inputs:
  - id: cmd
    type: string
    doc: 'Command to execute. Available commands: info, compile, ref, count, extract'
    inputBinding:
      position: 1
  - id: list
    type:
      - 'null'
      - boolean
    doc: Display list of supported single-cell technologies
    inputBinding:
      position: 102
      prefix: --list
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kb-python:0.30.0--pyh7e72e81_0
stdout: kb-python_kb.out
