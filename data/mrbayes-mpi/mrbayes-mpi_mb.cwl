cwlVersion: v1.2
class: CommandLineTool
baseCommand: mb
label: mrbayes-mpi_mb
doc: "MrBayes is a program for Bayesian inference and model selection in a phylogenetic
  framework. (Note: The provided help text contained only system error messages and
  no usage information).\n\nTool homepage: http://mrbayes.sourceforge.net"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mrbayes-mpi:v3.2.6dfsg-1b4-deb_cv1
stdout: mrbayes-mpi_mb.out
