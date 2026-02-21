cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_io
label: biobb_io
doc: "The provided text does not contain help information or usage instructions for
  the tool. It appears to be a system error log related to a container build failure
  (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
stdout: biobb_io.out
