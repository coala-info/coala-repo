cwlVersion: v1.2
class: CommandLineTool
baseCommand: linearpartition
label: linearpartition
doc: "The provided text does not contain help information or a description of the
  tool; it contains system log messages and a fatal error regarding container image
  conversion and disk space.\n\nTool homepage: https://github.com/LinearFold/LinearPartition"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linearpartition:1.0.1.dev20240123--h9948957_1
stdout: linearpartition.out
