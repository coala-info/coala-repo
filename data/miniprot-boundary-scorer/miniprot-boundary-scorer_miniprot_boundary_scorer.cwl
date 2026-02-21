cwlVersion: v1.2
class: CommandLineTool
baseCommand: miniprot-boundary-scorer
label: miniprot-boundary-scorer_miniprot_boundary_scorer
doc: "The provided help text contains only container runtime error messages and does
  not include usage information or argument descriptions.\n\nTool homepage: https://github.com/tomasbruna/miniprot-boundary-scorer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miniprot-boundary-scorer:1.0.1--h9948957_0
stdout: miniprot-boundary-scorer_miniprot_boundary_scorer.out
