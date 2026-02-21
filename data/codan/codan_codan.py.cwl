cwlVersion: v1.2
class: CommandLineTool
baseCommand: codan_codan.py
label: codan_codan.py
doc: "CODAN (COding sequence Detection and ANnotation) is a tool for identifying and
  annotating coding sequences. Note: The provided help text contains only system error
  messages and does not list specific arguments.\n\nTool homepage: https://github.com/pedronachtigall/CodAn"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codan:1.2--hdfd78af_1
stdout: codan_codan.py.out
