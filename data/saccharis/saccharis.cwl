cwlVersion: v1.2
class: CommandLineTool
baseCommand: saccharis
label: saccharis
doc: "Saccharis: a tool for CAZyme discovery and carbohydrate research (Note: The
  provided input text was a container log and did not contain help documentation).\n
  \nTool homepage: https://github.com/saccharis/SACCHARIS_2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/saccharis:2.0.5--pyh7e72e81_0
stdout: saccharis.out
