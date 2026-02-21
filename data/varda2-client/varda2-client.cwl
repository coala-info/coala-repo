cwlVersion: v1.2
class: CommandLineTool
baseCommand: varda2-client
label: varda2-client
doc: "The provided text does not contain help information or usage instructions for
  varda2-client. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/varda/varda2-client"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/varda2-client:0.9--py_0
stdout: varda2-client.out
