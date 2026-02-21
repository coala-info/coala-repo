cwlVersion: v1.2
class: CommandLineTool
baseCommand: python3
label: python3-biopython
doc: "The provided text does not contain help information or a description for the
  tool. It appears to be a fatal error log from a container runtime (Apptainer/Singularity)
  attempting to fetch a Docker image.\n\nTool homepage: https://github.com/aur-archive/python3-biopython"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-biopython:v1.68dfsg-3-deb_cv1
stdout: python3-biopython.out
