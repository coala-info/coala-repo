cwlVersion: v1.2
class: CommandLineTool
baseCommand: igda-script
label: igda-script
doc: "The provided text does not contain help information or usage instructions. It
  consists of system log messages and a fatal error regarding container image retrieval
  and disk space.\n\nTool homepage: https://github.com/zhixingfeng/shell"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igda-script:1.0.1--hdfd78af_0
stdout: igda-script.out
