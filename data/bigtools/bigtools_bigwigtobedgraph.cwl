cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigwigtobedgraph
label: bigtools_bigwigtobedgraph
doc: "A tool to convert bigWig files to bedGraph format. (Note: The provided text
  is an error log and does not contain help documentation; arguments could not be
  extracted.)\n\nTool homepage: https://github.com/jackh726/bigtools/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bigtools:0.5.6--hc1c3326_1
stdout: bigtools_bigwigtobedgraph.out
