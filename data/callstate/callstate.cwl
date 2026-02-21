cwlVersion: v1.2
class: CommandLineTool
baseCommand: callstate
label: callstate
doc: "The provided text does not contain help or usage information for the tool 'callstate'.
  It contains error logs related to a container image build failure (no space left
  on device).\n\nTool homepage: https://github.com/LuobinY/Callstate"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/callstate:0.0.2--h0fde405_1
stdout: callstate.out
