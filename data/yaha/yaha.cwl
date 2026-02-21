cwlVersion: v1.2
class: CommandLineTool
baseCommand: yaha
label: yaha
doc: "The provided text does not contain help information for the tool 'yaha'. It
  contains error logs related to fetching a container image.\n\nTool homepage: https://github.com/jannson/yaha"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/yaha:v0.1.83-1-deb_cv1
stdout: yaha.out
