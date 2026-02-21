cwlVersion: v1.2
class: CommandLineTool
baseCommand: vclust
label: vclust
doc: "The provided text contains container runtime logs and a fatal error message
  rather than the tool's help documentation. Consequently, no arguments or functional
  descriptions could be extracted.\n\nTool homepage: https://github.com/refresh-bio/vclust"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vclust:1.3.1--py313h9ee0642_0
stdout: vclust.out
