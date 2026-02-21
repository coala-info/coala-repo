cwlVersion: v1.2
class: CommandLineTool
baseCommand: rearr
label: rearr
doc: "A tool for rearrangement analysis (Note: The provided text contains execution
  logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/ljw20180420/sx_lcy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rearr:1.0.11--h9948957_0
stdout: rearr.out
