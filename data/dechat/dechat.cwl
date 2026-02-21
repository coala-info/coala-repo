cwlVersion: v1.2
class: CommandLineTool
baseCommand: dechat
label: dechat
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/LuoGroup2023/DeChat"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dechat:1.0.1--h56e2c18_1
stdout: dechat.out
