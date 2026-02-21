cwlVersion: v1.2
class: CommandLineTool
baseCommand: pycli_SimpleExample.py
label: pycli_SimpleExample.py
doc: "A Python CLI tool (Note: The provided text appears to be a container execution
  log rather than help text, so no arguments could be extracted).\n\nTool homepage:
  https://github.com/markovi/PyClick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pycli:2.0.3--py35_0
stdout: pycli_SimpleExample.py.out
