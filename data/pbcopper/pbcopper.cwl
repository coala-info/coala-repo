cwlVersion: v1.2
class: CommandLineTool
baseCommand: pbcopper
label: pbcopper
doc: "The provided text does not contain help information or documentation for the
  tool. It consists of system error messages related to container image retrieval
  and disk space issues.\n\nTool homepage: https://github.com/PacificBiosciences/pbcopper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pbcopper:2.3.0--h4ac6f70_3
stdout: pbcopper.out
