cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphanalyzer_graphanalyzer.py
label: graphanalyzer_graphanalyzer.py
doc: "A tool for graph analysis. (Note: The provided input text contains container
  runtime error messages rather than the tool's help documentation, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/lazzarigioele/graphanalyzer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphanalyzer:1.6.0--hdfd78af_0
stdout: graphanalyzer_graphanalyzer.py.out
