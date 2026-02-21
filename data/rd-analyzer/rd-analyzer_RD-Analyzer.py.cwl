cwlVersion: v1.2
class: CommandLineTool
baseCommand: RD-Analyzer.py
label: rd-analyzer_RD-Analyzer.py
doc: "RD-Analyzer (Note: The provided text contains container build logs and error
  messages rather than tool help text; no arguments could be extracted).\n\nTool homepage:
  https://github.com/xiaeryu/RD-Analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
stdout: rd-analyzer_RD-Analyzer.py.out
