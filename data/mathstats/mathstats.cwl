cwlVersion: v1.2
class: CommandLineTool
baseCommand: mathstats
label: mathstats
doc: "The provided text does not contain help information for the tool. It appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/ksahlin/mathstats"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mathstats:0.2.6.5--py_0
stdout: mathstats.out
