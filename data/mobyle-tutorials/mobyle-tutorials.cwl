cwlVersion: v1.2
class: CommandLineTool
baseCommand: mobyle-tutorials
label: mobyle-tutorials
doc: The provided text contains error logs from a container runtime (Apptainer/Singularity)
  rather than CLI help documentation. As a result, no functional description or arguments
  could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/mobyle-tutorials:v1.5.0-4-deb_cv1
stdout: mobyle-tutorials.out
