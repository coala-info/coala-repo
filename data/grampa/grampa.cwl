cwlVersion: v1.2
class: CommandLineTool
baseCommand: grampa
label: grampa
doc: "The provided text does not contain help information or a description of the
  tool. It contains error logs related to a container runtime failure.\n\nTool homepage:
  https://github.com/gwct/grampa"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/grampa:1.4.4--pyhdfd78af_0
stdout: grampa.out
