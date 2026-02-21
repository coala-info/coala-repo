cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypeflow_pwatcher
label: pypeflow_pwatcher
doc: "The provided text does not contain help information for pypeflow_pwatcher; it
  appears to be a log of a failed container build process.\n\nTool homepage: https://github.com/PacificBiosciences/pypeFLOW"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypeflow:2.2.0--py27_0
stdout: pypeflow_pwatcher.out
