cwlVersion: v1.2
class: CommandLineTool
baseCommand: configureHomer.pl
label: homer_configureHomer.pl
doc: "A script to configure, install, and update HOMER (Hypergeometric Optimization
  of Motif EnRichment) and its associated data packages.\n\nTool homepage: http://homer.ucsd.edu/homer/index.html"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/homer:5.1--pl5262h9948957_0
stdout: homer_configureHomer.pl.out
