cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-intervaltree-bio
label: python3-intervaltree-bio
doc: The provided text does not contain help information for the tool. It appears
  to be a fatal error log from a container runtime (Apptainer/Singularity) attempting
  to fetch a Docker image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-intervaltree-bio:v1.0.1-1-deb_cv1
stdout: python3-intervaltree-bio.out
