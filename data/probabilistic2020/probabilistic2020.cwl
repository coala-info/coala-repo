cwlVersion: v1.2
class: CommandLineTool
baseCommand: probabilistic2020
label: probabilistic2020
doc: "The provided text contains container environment logs and a fatal error message
  rather than the tool's help documentation. As a result, no arguments or functional
  descriptions could be extracted.\n\nTool homepage: https://github.com/KarchinLab/probabilistic2020"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/probabilistic2020:1.2.3--py36hd5865be_5
stdout: probabilistic2020.out
