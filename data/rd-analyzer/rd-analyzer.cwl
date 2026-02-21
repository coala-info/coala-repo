cwlVersion: v1.2
class: CommandLineTool
baseCommand: rd-analyzer
label: rd-analyzer
doc: "The provided text appears to be a container build error log rather than help
  text. No command-line arguments or tool descriptions could be extracted from the
  input.\n\nTool homepage: https://github.com/xiaeryu/RD-Analyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0
stdout: rd-analyzer.out
