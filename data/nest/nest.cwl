cwlVersion: v1.2
class: CommandLineTool
baseCommand: nest
label: nest
doc: "The provided text does not contain help information for the 'nest' tool; it
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  http://www.nest-simulator.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nest:2.14.0--py36_2
stdout: nest.out
