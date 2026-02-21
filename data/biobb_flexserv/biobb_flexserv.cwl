cwlVersion: v1.2
class: CommandLineTool
baseCommand: biobb_flexserv
label: biobb_flexserv
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a system error log indicating a failure to build or extract
  a container image due to insufficient disk space.\n\nTool homepage: https://github.com/bioexcel/biobb_flexserv"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biobb_flexserv:5.2.0--pypl5321hdfd78af_1
stdout: biobb_flexserv.out
