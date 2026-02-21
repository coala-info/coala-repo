cwlVersion: v1.2
class: CommandLineTool
baseCommand: macs
label: macs
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failing
  to pull or build the MACS image due to insufficient disk space.\n\nTool homepage:
  http://liulab.dfci.harvard.edu/MACS/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/macs:v2.1.2.1-1-deb_cv1
stdout: macs.out
