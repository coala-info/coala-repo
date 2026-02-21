cwlVersion: v1.2
class: CommandLineTool
baseCommand: tritimap
label: tritimap
doc: "A tool for mapping and analysis (Note: The provided text contains system error
  logs rather than help documentation, so specific arguments could not be extracted).\n
  \nTool homepage: https://github.com/fei0810/Triti-Map"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tritimap:0.9.7--pyh5e36f6f_0
stdout: tritimap.out
