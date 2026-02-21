cwlVersion: v1.2
class: CommandLineTool
baseCommand: dingii
label: dingii
doc: "A tool for genomic island identification (Note: The provided text contains execution
  logs and error messages rather than help documentation, so no arguments could be
  extracted).\n\nTool homepage: https://gitlab.ub.uni-bielefeld.de/gi/dingiiofficial"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dingii:0.0.1--pyhdfd78af_0
stdout: dingii.out
