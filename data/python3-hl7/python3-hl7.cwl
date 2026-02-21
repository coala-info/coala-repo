cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-hl7
label: python3-hl7
doc: The provided text does not contain help information for the tool 'python3-hl7'.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-hl7:v0.3.4-1-deb_cv1
stdout: python3-hl7.out
