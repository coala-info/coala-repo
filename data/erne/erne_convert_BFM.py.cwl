cwlVersion: v1.2
class: CommandLineTool
baseCommand: erne_convert_BFM.py
label: erne_convert_BFM.py
doc: "A tool for converting BFM files. (Note: The provided help text contains system
  error messages and does not list usage or arguments.)\n\nTool homepage: https://github.com/chengyuanba/avatar_ernerf"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/erne:2.1.1--boost1.61_0
stdout: erne_convert_BFM.py.out
