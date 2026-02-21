cwlVersion: v1.2
class: CommandLineTool
baseCommand: koverage
label: koverage
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container due to insufficient disk space.\n\nTool homepage:
  https://github.com/beardymcjohnface/Koverage"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/koverage:0.1.11--pyhdfd78af_0
stdout: koverage.out
