cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpirun
label: mrbayes-mpi_mpirun
doc: "MrBayes is a program for Bayesian inference and model choice across a wide range
  of phylogenetic and evolutionary models using Markov chain Monte Carlo (MCMC) methods.
  This version is configured to run with MPI support.\n\nTool homepage: http://mrbayes.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrbayes-mpi:v3.2.6dfsg-1b4-deb_cv1
stdout: mrbayes-mpi_mpirun.out
