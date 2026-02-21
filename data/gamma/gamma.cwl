cwlVersion: v1.2
class: CommandLineTool
baseCommand: gamma
label: gamma
doc: "The provided text does not contain help information or usage instructions; it
  is an error log reporting a failure to build a container image due to insufficient
  disk space.\n\nTool homepage: https://github.com/rastanton/GAMMA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gamma:2.2--hdfd78af_1
stdout: gamma.out
