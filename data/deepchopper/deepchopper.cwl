cwlVersion: v1.2
class: CommandLineTool
baseCommand: deepchopper
label: deepchopper
doc: "The provided text does not contain help information or a description of the
  tool; it contains container execution logs and a fatal error regarding disk space.\n
  \nTool homepage: https://github.com/ylab-hi/DeepChopper"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deepchopper:1.2.9--py310h9e6395a_0
stdout: deepchopper.out
