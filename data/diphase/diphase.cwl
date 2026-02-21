cwlVersion: v1.2
class: CommandLineTool
baseCommand: diphase
label: diphase
doc: "The provided text contains error logs from a container runtime and does not
  include the tool's help documentation. As a result, no arguments could be extracted.\n
  \nTool homepage: https://github.com/zhangjuncsu/Diphase"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/diphase:1.0.3--h739ee2d_0
stdout: diphase.out
