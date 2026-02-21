cwlVersion: v1.2
class: CommandLineTool
baseCommand: faidx
label: python3-pyfaidx
doc: The provided text does not contain help information; it appears to be a container
  execution error log from Apptainer/Singularity. No arguments could be extracted.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-pyfaidx:v0.4.8.1-1-deb_cv1
stdout: python3-pyfaidx.out
