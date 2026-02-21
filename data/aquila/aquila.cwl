cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquila
label: aquila
doc: "The provided text does not contain help information as the executable was not
  found in the environment.\n\nTool homepage: https://github.com/maiziex/Aquila"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila.out
