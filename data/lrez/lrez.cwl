cwlVersion: v1.2
class: CommandLineTool
baseCommand: lrez
label: lrez
doc: "The provided text does not contain help information for the tool 'lrez'; it
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/flegeai/LRez"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lrez:2.2.4--h077b44d_4
stdout: lrez.out
