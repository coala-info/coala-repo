cwlVersion: v1.2
class: CommandLineTool
baseCommand: imods
label: imods
doc: "The provided text does not contain help information for the tool 'imods'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build or pull the container image due to insufficient disk space.\n
  \nTool homepage: https://chaconlab.org/multiscale-simulations/imod"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/imods:1.0.4--h9ee0642_3
stdout: imods.out
