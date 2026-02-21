cwlVersion: v1.2
class: CommandLineTool
baseCommand: shapeshifter
label: shapeshifter_ea
doc: "The provided text contains system logs and error messages related to a container
  build process rather than the command-line help text for the tool. Consequently,
  no arguments or descriptions could be extracted.\n\nTool homepage: https://github.com/srp33/ShapeShifter"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/shapeshifter:1.1.1--pyh24bf2e0_0
stdout: shapeshifter_ea.out
