cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphanalyzer
label: graphanalyzer
doc: "A tool for graph analysis (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/lazzarigioele/graphanalyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphanalyzer:1.6.0--hdfd78af_0
stdout: graphanalyzer.out
