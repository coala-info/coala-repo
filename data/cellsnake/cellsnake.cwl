cwlVersion: v1.2
class: CommandLineTool
baseCommand: cellsnake
label: cellsnake
doc: "The provided text does not contain help information or a description of the
  tool; it is a log of a failed container build/execution due to insufficient disk
  space.\n\nTool homepage: https://github.com/sinanugur/cellsnake"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cellsnake:0.2.0.12--pyh7cba7a3_0
stdout: cellsnake.out
