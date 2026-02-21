cwlVersion: v1.2
class: CommandLineTool
baseCommand: ska
label: ska2_ska
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a log of a failed container build/fetch process.\n\n
  Tool homepage: https://github.com/bacpop/ska.rust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
stdout: ska2_ska.out
