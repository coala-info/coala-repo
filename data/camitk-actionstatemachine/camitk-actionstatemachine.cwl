cwlVersion: v1.2
class: CommandLineTool
baseCommand: camitk-actionstatemachine
label: camitk-actionstatemachine
doc: 'A tool within the CamiTK (Computer Assisted Medical Intervention ToolKit) framework
  for managing action state machines. Note: The provided input text contains container
  execution/build errors and does not list specific command-line arguments.'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/camitk-actionstatemachine:v4.1.2-3-deb_cv1
stdout: camitk-actionstatemachine.out
