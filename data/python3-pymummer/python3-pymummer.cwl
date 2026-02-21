cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-pymummer
label: python3-pymummer
doc: The provided text does not contain help information or a description of the tool.
  It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch or build the OCI image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pymummer:v0.10.1-1-deb_cv1
stdout: python3-pymummer.out
