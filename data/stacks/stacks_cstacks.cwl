cwlVersion: v1.2
class: CommandLineTool
baseCommand: cstacks
label: stacks_cstacks
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log related to a container build failure.\n\nTool homepage:
  https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_cstacks.out
