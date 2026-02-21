cwlVersion: v1.2
class: CommandLineTool
baseCommand: samstrip
label: samstrip
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build process for the samstrip image.\n
  \nTool homepage: https://github.com/jakobnissen/samstrip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/samstrip:0.2.1--h4349ce8_0
stdout: samstrip.out
