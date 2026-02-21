cwlVersion: v1.2
class: CommandLineTool
baseCommand: glimmer
label: glimmer
doc: "The provided text does not contain help information for the tool; it is an error
  message indicating a failure to build a container image due to lack of disk space.\n
  \nTool homepage: https://github.com/glimmerjs/glimmer-vm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glimmer:3.02--2
stdout: glimmer.out
