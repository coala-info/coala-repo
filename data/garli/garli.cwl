cwlVersion: v1.2
class: CommandLineTool
baseCommand: garli
label: garli
doc: "Genetic Algorithm for Rapid Likelihood Inference (GARLI) for phylogenetic analysis.\n
  \nTool homepage: https://github.com/guillaumepotier/Garlic.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/garli:v2.1-3-deb_cv1
stdout: garli.out
