cwlVersion: v1.2
class: CommandLineTool
baseCommand: kiwidist
label: kiwidist
doc: The provided text does not contain help information for kiwidist; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kiwidist:0.3.6--py27_2
stdout: kiwidist.out
