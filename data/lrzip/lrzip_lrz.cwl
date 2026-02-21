cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrz
label: lrzip_lrz
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log regarding container image building and disk space issues.\n
  \nTool homepage: https://github.com/ckolivas/lrzip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrzip:0.651--h32784b6_1
stdout: lrzip_lrz.out
