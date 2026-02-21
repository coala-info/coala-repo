cwlVersion: v1.2
class: CommandLineTool
baseCommand: pisadCount
label: pisad_pisadCount
doc: "The provided text does not contain help information for the tool, as it is an
  error log from a container build process. No arguments could be extracted.\n\nTool
  homepage: https://github.com/ZhantianXu/PISAD"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pisad:1.2.0--pl5321h6f0a7f7_0
stdout: pisad_pisadCount.out
