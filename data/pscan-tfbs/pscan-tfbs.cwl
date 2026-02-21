cwlVersion: v1.2
class: CommandLineTool
baseCommand: pscan-tfbs
label: pscan-tfbs
doc: The provided text contains error messages from a container runtime (Apptainer/Singularity)
  and does not include the help documentation for pscan-tfbs. As a result, no arguments
  or tool descriptions could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pscan-tfbs:v1.2.2-3-deb_cv1
stdout: pscan-tfbs.out
