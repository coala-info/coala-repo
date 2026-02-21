cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3-fast5
label: python3-fast5
doc: The provided text does not contain help information or usage instructions. It
  appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  failing to fetch the image.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-fast5:v0.5.8-1b2-deb_cv1
stdout: python3-fast5.out
