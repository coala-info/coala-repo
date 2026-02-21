cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyflow_pyflow_run.py
label: pyflow_pyflow_run.py
doc: "The provided text does not contain help information for pyflow_pyflow_run.py;
  it appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/pedroCabrera/PyFlow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pyflow:v1.1.20-1-deb-py2_cv1
stdout: pyflow_pyflow_run.py.out
