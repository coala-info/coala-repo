cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeshifter
label: shapeshifter
doc: "The provided text is an error log from a container build/execution process and
  does not contain help information or usage instructions for the tool 'shapeshifter'.\n
  \nTool homepage: https://github.com/srp33/ShapeShifter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter:1.1.1--pyh24bf2e0_0
stdout: shapeshifter.out
