cwlVersion: v1.2
class: CommandLineTool
baseCommand: pb-falcon
label: pb-falcon
doc: "The provided text does not contain help information for pb-falcon; it contains
  system error messages regarding container execution and disk space issues.\n\nTool
  homepage: https://github.com/PacificBiosciences/pypeFLOW"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pb-falcon:2.2.4--py311h384fd50_7
stdout: pb-falcon.out
