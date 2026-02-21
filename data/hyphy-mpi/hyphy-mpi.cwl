cwlVersion: v1.2
class: CommandLineTool
baseCommand: hyphy-mpi
label: hyphy-mpi
doc: "HyPhy (Hypothesis Testing using Phylogenies) is an open-source software package
  for the analysis of genetic sequences using techniques in phylogenetics, molecular
  evolution, and machine learning. (Note: The provided text is a container execution
  error log and does not contain help documentation).\n\nTool homepage: http://hyphy.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/hyphy-mpi:v2.3.14dfsg-1-deb_cv1
stdout: hyphy-mpi.out
