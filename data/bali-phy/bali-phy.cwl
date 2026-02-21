cwlVersion: v1.2
class: CommandLineTool
baseCommand: bali-phy
label: bali-phy
doc: "BAli-Phy is a software for simultaneous Bayesian estimation of alignment and
  phylogeny.\n\nTool homepage: http://www.bali-phy.org"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bali-phy:4.1--py314hedd121d_0
stdout: bali-phy.out
