cwlVersion: v1.2
class: CommandLineTool
baseCommand: readucks
label: readucks
doc: "The provided text does not contain help information or a description of the
  tool's functionality. It appears to be a log of a failed container build/fetch process.\n
  \nTool homepage: https://github.com/artic-network/readucks"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/readucks:0.0.3--py_0
stdout: readucks.out
