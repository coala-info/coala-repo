cwlVersion: v1.2
class: CommandLineTool
baseCommand: tadlib
label: tadlib
doc: "The provided text does not contain help information or usage instructions for
  tadlib; it is a container engine error log.\n\nTool homepage: https://github.com/XiaoTaoWang/TADLib/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tadlib:0.4.5.post1--pyhdfd78af_1
stdout: tadlib.out
