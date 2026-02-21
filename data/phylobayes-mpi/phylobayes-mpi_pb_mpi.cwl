cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pb_mpi
label: phylobayes-mpi_pb_mpi
doc: "PhyloBayes MPI: A Bayesian Monte Carlo Markov Chain (MCMC) sampler for phylogenetic
  reconstruction using MPI.\n\nTool homepage: https://github.com/bayesiancook/pbmpi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phylobayes-mpi:1.9--h5c6ebe3_0
stdout: phylobayes-mpi_pb_mpi.out
