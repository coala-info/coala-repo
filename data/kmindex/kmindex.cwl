cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmindex
label: kmindex
doc: "A tool for indexing k-mers (Note: The provided help text contains only container
  runtime error messages and no usage information).\n\nTool homepage: https://github.com/tlemane/kmindex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmindex:0.6.0--h668145b_1
stdout: kmindex.out
