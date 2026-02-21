cwlVersion: v1.2
class: CommandLineTool
baseCommand: predicthaplo
label: predicthaplo
doc: "PredictHaplo is a tool for reconstructing viral haplotypes from next-generation
  sequencing data. (Note: The provided input text contains container runtime error
  logs rather than the tool's help documentation; therefore, no arguments could be
  extracted.)\n\nTool homepage: https://github.com/cbg-ethz/PredictHaplo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predicthaplo:2.1.4--h9b88814_6
stdout: predicthaplo.out
