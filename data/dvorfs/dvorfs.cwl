cwlVersion: v1.2
class: CommandLineTool
baseCommand: dvorfs
label: dvorfs
doc: "The provided text does not contain help information or a description of the
  tool; it contains system error logs related to a container build failure.\n\nTool
  homepage: https://github.com/ilevantis/dvorfs"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dvorfs:1.0.1--pyhdfd78af_0
stdout: dvorfs.out
