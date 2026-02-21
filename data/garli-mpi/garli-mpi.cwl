cwlVersion: v1.2
class: CommandLineTool
baseCommand: garli-mpi
label: garli-mpi
doc: 'GARLI (Genetic Algorithm for Rapid Likelihood Inference) is a program for phylogenetic
  inference using the maximum likelihood criterion. (Note: The provided help text
  contains system error messages and does not list specific arguments).'
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/garli-mpi:v2.1-3-deb_cv1
stdout: garli-mpi.out
