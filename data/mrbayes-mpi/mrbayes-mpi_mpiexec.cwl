cwlVersion: v1.2
class: CommandLineTool
baseCommand: mrbayes-mpi_mpiexec
label: mrbayes-mpi_mpiexec
doc: "MrBayes is a program for Bayesian inference and model choice across a wide range
  of phylogenetic and evolutionary models. (Note: The provided text contains container
  runtime error messages rather than help documentation; no arguments could be extracted.)\n
  \nTool homepage: http://mrbayes.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrbayes-mpi:v3.2.6dfsg-1b4-deb_cv1
stdout: mrbayes-mpi_mpiexec.out
