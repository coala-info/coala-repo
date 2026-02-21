cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyflow_pyflow.py
label: pyflow_pyflow.py
doc: "A lightweight parallel task engine (Note: The provided text appears to be a
  container execution log rather than CLI help text, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/pedroCabrera/PyFlow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pyflow:v1.1.20-1-deb-py2_cv1
stdout: pyflow_pyflow.py.out
