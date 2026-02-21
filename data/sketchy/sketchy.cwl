cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchy
label: sketchy
doc: "A tool for real-time lineage calling and genotyping (Note: The provided text
  appears to be a container build log rather than help text; no arguments could be
  extracted from the input).\n\nTool homepage: https://github.com/esteinig/sketchy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
stdout: sketchy.out
