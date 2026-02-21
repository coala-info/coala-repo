cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy
label: iobrpy
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains system log messages and a fatal error regarding container
  image building (no space left on device).\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
stdout: iobrpy.out
