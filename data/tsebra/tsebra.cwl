cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsebra
label: tsebra
doc: "TSEBRA (Transcript Selector for BRAKER) is a tool to combine gene predictions
  from different sources. (Note: The provided text is an error log and does not contain
  help information or argument definitions).\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
stdout: tsebra.out
