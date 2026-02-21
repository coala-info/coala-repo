cwlVersion: v1.2
class: CommandLineTool
baseCommand: genometools-common
label: genometools-common
doc: The provided text does not contain help information for the tool; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container image due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometools-common:v1.5.9ds-4-deb_cv1
stdout: genometools-common.out
