cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrztar
label: lrzip_lrztar
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log indicating a failure to build a container image due to
  insufficient disk space.\n\nTool homepage: https://github.com/ckolivas/lrzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrzip:0.651--h32784b6_1
stdout: lrzip_lrztar.out
