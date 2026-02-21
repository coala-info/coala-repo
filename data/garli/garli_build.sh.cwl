cwlVersion: v1.2
class: CommandLineTool
baseCommand: garli_build.sh
label: garli_build.sh
doc: "A script for building or managing GARLI (Genetic Algorithm for Rapid Likelihood
  Inference) container images.\n\nTool homepage: https://github.com/guillaumepotier/Garlic.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/garli:v2.1-3-deb_cv1
stdout: garli_build.sh.out
