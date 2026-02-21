cwlVersion: v1.2
class: CommandLineTool
baseCommand: alter-sequence-alignment
label: alter-sequence-alignment
doc: The provided text does not contain help information for the tool; it is a fatal
  error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to insufficient disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/alter-sequence-alignment:v1.3.4-2-deb_cv1
stdout: alter-sequence-alignment.out
