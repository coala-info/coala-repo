cwlVersion: v1.2
class: CommandLineTool
baseCommand: anospp-analysis
label: anospp-analysis
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container build process.\n\nTool homepage: https://pypi.org/project/anospp-analysis/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/anospp-analysis:0.4.0--pyhdfd78af_1
stdout: anospp-analysis.out
