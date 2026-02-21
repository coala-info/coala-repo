cwlVersion: v1.2
class: CommandLineTool
baseCommand: FeGenie.py
label: fegenie_FeGenie.py
doc: "FeGenie: a tool for the identification of iron-related genes and pathways. (Note:
  The provided help text contained system error messages regarding container execution
  and did not list specific command-line arguments.)\n\nTool homepage: https://github.com/Arkadiy-Garber/FeGenie"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fegenie:1.2--py313r40hdfd78af_5
stdout: fegenie_FeGenie.py.out
