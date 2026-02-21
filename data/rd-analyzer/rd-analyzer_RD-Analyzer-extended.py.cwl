cwlVersion: v1.2
class: CommandLineTool
baseCommand: RD-Analyzer-extended.py
label: rd-analyzer_RD-Analyzer-extended.py
doc: "RD-Analyzer is a tool for detecting Rare Diseases (RD) or analyzing genomic
  data, however, the provided text contains only system logs and error messages rather
  than help documentation.\n\nTool homepage: https://github.com/xiaeryu/RD-Analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
stdout: rd-analyzer_RD-Analyzer-extended.py.out
