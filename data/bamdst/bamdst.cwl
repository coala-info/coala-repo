cwlVersion: v1.2
class: CommandLineTool
baseCommand: bamdst
label: bamdst
doc: "The provided text does not contain help information for the tool; it is a system
  error log indicating a failure to pull a container image due to lack of disk space.\n\
  \nTool homepage: https://github.com/shiquan/bamdst"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/bamdst:1.0.9_cv1
stdout: bamdst.out
