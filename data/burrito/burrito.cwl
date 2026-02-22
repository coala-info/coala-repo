cwlVersion: v1.2
class: CommandLineTool
baseCommand: burrito
label: burrito
doc: "The provided text contains system error logs related to container image conversion
  and does not contain help documentation or usage instructions for the tool 'burrito'.\n\
  \nTool homepage: https://github.com/guillermomuntaner/Burritos"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/burrito:v0.9.1-3-deb-py3_cv1
stdout: burrito.out
