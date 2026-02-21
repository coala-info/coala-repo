cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_haddock
label: biobb_haddock
doc: "The provided text does not contain help information or usage instructions for
  the tool. It consists of system log messages indicating a failure during a container
  build process (no space left on device).\n\nTool homepage: https://github.com/bioexcel/biobb_haddock"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_haddock:5.2.0--pyhdfd78af_0
stdout: biobb_haddock.out
