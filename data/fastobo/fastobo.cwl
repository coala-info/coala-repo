cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastobo
label: fastobo
doc: "A tool for parsing and processing OBO files (Note: The provided input text contains
  container runtime error messages rather than the tool's help documentation).\n\n
  Tool homepage: https://github.com/fastobo/fastobo-py"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastobo:0.13.0--py39h77f74c3_0
stdout: fastobo.out
