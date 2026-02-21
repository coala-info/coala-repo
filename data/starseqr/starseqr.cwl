cwlVersion: v1.2
class: CommandLineTool
baseCommand: starseqr
label: starseqr
doc: "The provided text contains container runtime logs and does not include help
  information or a description for the tool.\n\nTool homepage: https://github.com/ExpressionAnalysis/STAR-SEQR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/starseqr:0.6.7--py27h7eb728f_0
stdout: starseqr.out
