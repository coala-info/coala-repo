cwlVersion: v1.2
class: CommandLineTool
baseCommand: x-mapper
label: x-mapper
doc: "The provided text does not contain help information or usage instructions for
  x-mapper; it is an error log from a container build process. No arguments could
  be extracted.\n\nTool homepage: https://github.com/mathjeff/mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/x-mapper:1.2.0--hdfd78af_0
stdout: x-mapper.out
