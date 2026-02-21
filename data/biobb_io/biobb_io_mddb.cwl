cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mddb
label: biobb_io_mddb
doc: "The provided text does not contain help information or documentation for the
  tool; it consists of system logs and a fatal error message regarding a container
  build failure (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
stdout: biobb_io_mddb.out
