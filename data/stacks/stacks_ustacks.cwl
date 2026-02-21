cwlVersion: v1.2
class: CommandLineTool
baseCommand: ustacks
label: stacks_ustacks
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution error log indicating a failure to fetch or build the
  OCI image.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stacks:2.68--h077b44d_3
stdout: stacks_ustacks.out
