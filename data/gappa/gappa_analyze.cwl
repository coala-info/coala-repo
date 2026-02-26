cwlVersion: v1.2
class: CommandLineTool
baseCommand: gappa analyze
label: gappa_analyze
doc: "Commands for analyzing and comparing placement data, that is, finding differences
  and patterns.\n\nTool homepage: https://github.com/lczech/gappa"
inputs:
  - id: subcommand
    type: string
    doc: 'The subcommand to run. Available subcommands: correlation, dispersion, edgepca,
      imbalance-kmeans, krd, phylogenetic-kmeans, placement-factorization, squash.'
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gappa:0.9.0--h077b44d_0
stdout: gappa_analyze.out
