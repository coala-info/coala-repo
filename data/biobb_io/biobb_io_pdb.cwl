cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_io_pdb
label: biobb_io_pdb
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a system error log indicating a failure to build a container image
  due to insufficient disk space ('no space left on device').\n\nTool homepage: https://github.com/bioexcel/biobb_io"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_io:5.2.2--pyhdfd78af_0
stdout: biobb_io_pdb.out
