cwlVersion: v1.2
class: CommandLineTool
baseCommand: go-figure
label: go-figure
doc: "A tool for processing or visualizing data (Note: The provided help text contains
  only system error logs and no usage information).\n\nTool homepage: https://gitlab.com/evogenlab/GO-Figure"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/go-figure:1.0.2--hdfd78af_0
stdout: go-figure.out
