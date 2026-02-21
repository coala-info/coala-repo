cwlVersion: v1.2
class: CommandLineTool
baseCommand: clone_filter
label: stacks_clone_filter
doc: "The provided text does not contain help information for the tool. It appears
  to be a log of a failed container execution/build process.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_clone_filter.out
