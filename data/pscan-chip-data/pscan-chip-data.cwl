cwlVersion: v1.2
class: CommandLineTool
baseCommand: pscan-chip-data
label: pscan-chip-data
doc: The provided text contains error logs from a container runtime (Apptainer/Singularity)
  and does not include the help documentation or usage instructions for the tool 'pscan-chip-data'.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/pscan-chip-data:v1.1-2-deb_cv1
stdout: pscan-chip-data.out
