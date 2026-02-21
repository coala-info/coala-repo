cwlVersion: v1.2
class: CommandLineTool
baseCommand: stacks
label: stacks
doc: "The provided text is a container build log and does not contain help information
  or argument definitions for the 'stacks' tool.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks.out
