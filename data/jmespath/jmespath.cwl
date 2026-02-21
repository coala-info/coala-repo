cwlVersion: v1.2
class: CommandLineTool
baseCommand: jmespath
label: jmespath
doc: "The provided text does not contain a description of the tool's functionality,
  as it is an error log related to a container environment failure.\n\nTool homepage:
  https://github.com/jmespath/jmespath.py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/jmespath:0.9.0--py36_0
stdout: jmespath.out
