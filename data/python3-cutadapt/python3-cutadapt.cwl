cwlVersion: v1.2
class: CommandLineTool
baseCommand: cutadapt
label: python3-cutadapt
doc: "The provided text does not contain help information for the tool. It appears
  to be a set of system logs and a fatal error message from a container runtime (Singularity/Apptainer)
  failing to pull or build the image for python3-cutadapt.\n\nTool homepage: https://cutadapt.readthedocs.io/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/python3-cutadapt:v1.12-2-deb_cv1
stdout: python3-cutadapt.out
