cwlVersion: v1.2
class: CommandLineTool
baseCommand: gtfparse
label: gtfparse
doc: "A tool for parsing GTF (Gene Transfer Format) files into Pandas DataFrames or
  other structured formats.\n\nTool homepage: https://github.com/openvax/gtfparse"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gtfparse:2.5.0--pyh7cba7a3_0
stdout: gtfparse.out
