cwlVersion: v1.2
class: CommandLineTool
baseCommand: bacphlip
label: bacphlip
doc: "The provided text contains system error messages related to a container runtime
  failure ('no space left on device') and does not contain the help text or usage
  information for the tool 'bacphlip'.\n\nTool homepage: https://github.com/adamhockenberry/bacphlip"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bacphlip:0.9.6--py_0
stdout: bacphlip.out
