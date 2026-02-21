cwlVersion: v1.2
class: CommandLineTool
baseCommand: EToKi.py
label: etoki_EToKi.py
doc: "Enterobase ToolKit (EToKi) for genomic analysis. Note: The provided help text
  contains system error messages and does not list specific arguments.\n\nTool homepage:
  https://github.com/zheminzhou/EToKi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/etoki:1.2.3--hdfd78af_0
stdout: etoki_EToKi.py.out
