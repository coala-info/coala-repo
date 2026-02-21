cwlVersion: v1.2
class: CommandLineTool
baseCommand: beem
label: beem-bio_BeEM
doc: "BeEM (Biomass Estimation using Expectation-Maximization) is a tool for estimating
  microbial biomass from metagenomic data.\n\nTool homepage: https://github.com/kad-ecoli/BeEM"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/beem-bio:1.0.1--h9948957_0
stdout: beem-bio_BeEM.out
