cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyflow_pyflow-mdi.py
label: pyflow_pyflow-mdi.py
doc: "The provided text does not contain help information for the tool; it is a log
  of a failed container build process (Singularity/Apptainer).\n\nTool homepage: https://github.com/pedroCabrera/PyFlow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pyflow:v1.1.20-1-deb-py2_cv1
stdout: pyflow_pyflow-mdi.py.out
