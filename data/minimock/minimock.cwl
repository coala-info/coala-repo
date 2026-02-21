cwlVersion: v1.2
class: CommandLineTool
baseCommand: minimock
label: minimock
doc: "The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to lack of disk space.\n\nTool homepage: http://pypi.python.org/pypi/MiniMock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/minimock:1.2.8--py27_1
stdout: minimock.out
