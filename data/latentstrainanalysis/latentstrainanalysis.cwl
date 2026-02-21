cwlVersion: v1.2
class: CommandLineTool
baseCommand: latentstrainanalysis
label: latentstrainanalysis
doc: "Latent Strain Analysis (LSA) tool for metagenomic read partitioning.\n\nTool
  homepage: https://github.com/brian-cleary/LatentStrainAnalysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/latentstrainanalysis:0.0.1--py27_0
stdout: latentstrainanalysis.out
