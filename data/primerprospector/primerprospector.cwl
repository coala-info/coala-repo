cwlVersion: v1.2
class: CommandLineTool
baseCommand: primerprospector
label: primerprospector
doc: "No description available from the provided text.\n\nTool homepage: https://github.com/Ellmen/primerprospector3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/primerprospector:1.0.1--py27_0
stdout: primerprospector.out
