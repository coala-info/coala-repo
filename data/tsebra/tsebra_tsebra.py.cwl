cwlVersion: v1.2
class: CommandLineTool
baseCommand: tsebra.py
label: tsebra_tsebra.py
doc: "TSEBRA (Transcript Selector for BRAKER) is a tool to combine gene predictions
  from different sources. (Note: The provided input text contained only system error
  logs and no help documentation to parse arguments from).\n\nTool homepage: https://github.com/Gaius-Augustus/TSEBRA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tsebra:1.1.2.5--pyhca03a8a_0
stdout: tsebra_tsebra.py.out
