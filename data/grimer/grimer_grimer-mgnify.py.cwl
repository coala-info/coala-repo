cwlVersion: v1.2
class: CommandLineTool
baseCommand: grimer-mgnify.py
label: grimer_grimer-mgnify.py
doc: "The provided text does not contain help information or usage instructions. It
  contains system log messages and a fatal error regarding container image building
  (no space left on device).\n\nTool homepage: https://github.com/pirovc/grimer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grimer:1.1.0--pyhdfd78af_0
stdout: grimer_grimer-mgnify.py.out
