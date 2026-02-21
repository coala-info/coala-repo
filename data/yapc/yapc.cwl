cwlVersion: v1.2
class: CommandLineTool
baseCommand: yapc
label: yapc
doc: "The provided text does not contain help information or usage instructions for
  the tool 'yapc'. It appears to be a log of a failed container image retrieval process.\n
  \nTool homepage: https://github.com/jurgjn/yapc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/yapc:0.1--py_0
stdout: yapc.out
