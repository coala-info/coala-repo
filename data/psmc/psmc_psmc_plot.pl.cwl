cwlVersion: v1.2
class: CommandLineTool
baseCommand: psmc_psmc_plot.pl
label: psmc_psmc_plot.pl
doc: "A plotting script for PSMC (Pairwise Sequentially Markovian Coalescent) analysis
  results.\n\nTool homepage: https://github.com/lh3/psmc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/psmc:0.6.5--h5ca1c30_4
stdout: psmc_psmc_plot.pl.out
