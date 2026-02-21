cwlVersion: v1.2
class: CommandLineTool
baseCommand: graphclust-wrappers
label: graphclust-wrappers
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container runtime (Apptainer/Singularity) failing to
  build a SIF image due to lack of disk space.\n\nTool homepage: http://www.bioinf.uni-freiburg.de/Software/GraphClust/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/graphclust-wrappers:0.6.0--pl526_1
stdout: graphclust-wrappers.out
