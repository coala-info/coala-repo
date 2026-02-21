cwlVersion: v1.2
class: CommandLineTool
baseCommand: acedb-other
label: acedb-other
doc: The provided text does not contain help information for the tool. It is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to pull
  or build the container image due to insufficient disk space ('no space left on device').
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/acedb-other:v4.9.39dfsg.02-4-deb_cv1
stdout: acedb-other.out
