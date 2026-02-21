cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy
label: hyphy-mpi_hyphy
doc: "HyPhy (Hypothesis testing using Phylogenies) is a software package for the analysis
  of genetic sequences using techniques in phylogenetics, molecular evolution, and
  machine learning. Note: The provided help text contains only system error messages
  regarding container execution and does not list specific command-line arguments.\n
  \nTool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-mpi:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-mpi_hyphy.out
