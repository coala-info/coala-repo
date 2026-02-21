cwlVersion: v1.2
class: CommandLineTool
baseCommand: igdtools
label: igdtools
doc: "The provided text does not contain help information for igdtools; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container due to insufficient disk space.\n\nTool homepage: https://aprilweilab.github.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdtools:2.6--py312h5e9d817_0
stdout: igdtools.out
