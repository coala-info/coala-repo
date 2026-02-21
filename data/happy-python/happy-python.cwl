cwlVersion: v1.2
class: CommandLineTool
baseCommand: happy-python
label: happy-python
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.\n\nTool homepage: https://github.com/AntoineHo/HapPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/happy-python:0.2.1rc0--pyhdfd78af_0
stdout: happy-python.out
