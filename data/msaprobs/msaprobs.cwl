cwlVersion: v1.2
class: CommandLineTool
baseCommand: msaprobs
label: msaprobs
doc: "A tool for multiple sequence alignment (Note: The provided help text contains
  a system error regarding container execution and does not list tool-specific arguments).\n
  \nTool homepage: http://msaprobs.sourceforge.net/homepage.htm"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/msaprobs:0.9.7--h5ca1c30_5
stdout: msaprobs.out
