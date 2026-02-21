cwlVersion: v1.2
class: CommandLineTool
baseCommand: inspector_inspector.py
label: inspector_inspector.py
doc: "The provided text contains error logs and environment information rather than
  help documentation. No arguments or tool descriptions could be extracted from the
  input.\n\nTool homepage: https://github.com/ChongLab/Inspector"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/inspector:1.3.1--hdfd78af_1
stdout: inspector_inspector.py.out
