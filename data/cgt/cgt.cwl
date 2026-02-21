cwlVersion: v1.2
class: CommandLineTool
baseCommand: cgt
label: cgt
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains error logs from a container runtime environment.\n
  \nTool homepage: https://github.com/bacpop/cgt"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cgt:1.0.0--h4349ce8_0
stdout: cgt.out
