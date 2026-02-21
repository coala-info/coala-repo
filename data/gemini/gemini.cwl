cwlVersion: v1.2
class: CommandLineTool
baseCommand: gemini
label: gemini
doc: "A framework for exploring genome variation. (Note: The provided text contains
  system error logs rather than help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/arq5x/gemini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini.out
