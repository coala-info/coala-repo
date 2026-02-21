cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_remote
label: biobb_remote
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container build failure (no space left
  on device).\n\nTool homepage: https://github.com/bioexcel/biobb_remote"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_remote:1.2.2--pyhdfd78af_0
stdout: biobb_remote.out
