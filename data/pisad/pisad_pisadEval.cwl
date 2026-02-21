cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisadEval
label: pisad_pisadEval
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log indicating a failure to build or run a container due to
  lack of disk space.\n\nTool homepage: https://github.com/ZhantianXu/PISAD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad_pisadEval.out
