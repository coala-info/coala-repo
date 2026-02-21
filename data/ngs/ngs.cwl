cwlVersion: v1.2
class: CommandLineTool
baseCommand: ngs
label: ngs
doc: "The provided text does not contain help information for the 'ngs' tool. It is
  a system error message from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to insufficient disk space.\n\nTool homepage:
  https://github.com/gsklee/ngStorage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/ngs:v2.9.3-1-deb-py2_cv1
stdout: ngs.out
