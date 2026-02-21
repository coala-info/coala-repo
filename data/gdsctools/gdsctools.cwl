cwlVersion: v1.2
class: CommandLineTool
baseCommand: gdsctools
label: gdsctools
doc: "The provided text does not contain help information. It contains system log
  messages and a fatal error indicating that the tool failed to run due to insufficient
  disk space ('no space left on device') while attempting to build the container image.\n
  \nTool homepage: http://pypi.python.org/pypi/gdsctools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gdsctools:1.0.1--py_0
stdout: gdsctools.out
