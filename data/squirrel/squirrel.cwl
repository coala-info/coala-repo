cwlVersion: v1.2
class: CommandLineTool
baseCommand: squirrel
label: squirrel
doc: "The provided text does not contain a description of the tool. It appears to
  be an error log from a container execution or build process.\n\nTool homepage: https://github.com/aineniamh/squirrel"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/squirrel:1.3.2--pyhdfd78af_0
stdout: squirrel.out
