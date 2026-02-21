cwlVersion: v1.2
class: CommandLineTool
baseCommand: eastr
label: eastr
doc: "EASTR (Emendation of Alignment of Spliced Tenacious Reads) is a tool designed
  to identify and remove artifacts from spliced alignments. (Note: The provided text
  contains only system error logs and no help documentation; no arguments could be
  extracted.)\n\nTool homepage: https://github.com/ishinder/EASTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eastr:1.1.2--py311h2de2dd3_1
stdout: eastr.out
