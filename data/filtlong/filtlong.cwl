cwlVersion: v1.2
class: CommandLineTool
baseCommand: filtlong
label: filtlong
doc: "The provided text does not contain help information for filtlong; it contains
  error messages related to a container runtime (Apptainer/Singularity) failure due
  to lack of disk space.\n\nTool homepage: http://http://canu.readthedocs.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/filtlong:0.3.1--h077b44d_0
stdout: filtlong.out
