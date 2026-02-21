cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyflow
label: pyflow
doc: "The provided text does not contain help information for the tool 'pyflow'. It
  appears to be a log of a failed container build or execution attempt using Apptainer/Singularity.\n
  \nTool homepage: https://github.com/pedroCabrera/PyFlow"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pyflow:v1.1.20-1-deb-py2_cv1
stdout: pyflow.out
