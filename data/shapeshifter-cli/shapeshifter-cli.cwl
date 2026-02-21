cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeshifter-cli
label: shapeshifter-cli
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  process.\n\nTool homepage: https://github.com/srp33/ShapeShifter-CLI"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter-cli:1.0.0--py_0
stdout: shapeshifter-cli.out
