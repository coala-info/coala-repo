cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeshifter_expressionable
label: shapeshifter_expressionable
doc: "The provided text does not contain help information or a description for the
  tool; it is an error log from a container build process.\n\nTool homepage: https://github.com/srp33/ShapeShifter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter:1.1.1--pyh24bf2e0_0
stdout: shapeshifter_expressionable.out
