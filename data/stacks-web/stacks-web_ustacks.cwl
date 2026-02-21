cwlVersion: v1.2
class: CommandLineTool
baseCommand: ustacks
label: stacks-web_ustacks
doc: "The provided text does not contain help information; it appears to be a container
  execution error log.\n\nTool homepage: https://catchenlab.life.illinois.edu/stacks/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/stacks-web:v2.2dfsg-1-deb_cv1
stdout: stacks-web_ustacks.out
