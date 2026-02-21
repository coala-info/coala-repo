cwlVersion: v1.2
class: CommandLineTool
baseCommand: clusty
label: clusty
doc: "A tool for clustering (detailed description not available in the provided error
  log).\n\nTool homepage: https://github.com/refresh-bio/clusty"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clusty:1.2.2--h9ee0642_0
stdout: clusty.out
