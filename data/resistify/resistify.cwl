cwlVersion: v1.2
class: CommandLineTool
baseCommand: resistify
label: resistify
doc: "The provided text does not contain help information or a description of the
  tool; it contains system logs and a fatal error message regarding a container build
  failure.\n\nTool homepage: https://github.com/swiftseal/resistify"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/resistify:1.3.0--pyhdfd78af_0
stdout: resistify.out
