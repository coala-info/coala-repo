cwlVersion: v1.2
class: CommandLineTool
baseCommand: gcen
label: gcen
doc: "The provided text does not contain help information for the tool 'gcen'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://www.biochen.com/gcen/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gcen:0.6.3--h9f5acd7_3
stdout: gcen.out
