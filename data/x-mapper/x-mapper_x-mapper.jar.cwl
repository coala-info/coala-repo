cwlVersion: v1.2
class: CommandLineTool
baseCommand: x-mapper
label: x-mapper_x-mapper.jar
doc: "A tool for mapping (description unavailable from provided help text)\n\nTool
  homepage: https://github.com/mathjeff/mapper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/x-mapper:1.2.0--hdfd78af_0
stdout: x-mapper_x-mapper.jar.out
