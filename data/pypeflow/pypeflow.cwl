cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypeflow
label: pypeflow
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/fetch process.\n\nTool homepage: https://github.com/PacificBiosciences/pypeFLOW"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypeflow:2.2.0--py27_0
stdout: pypeflow.out
