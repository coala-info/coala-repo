cwlVersion: v1.2
class: CommandLineTool
baseCommand: eigenstratdatabasetools
label: eigenstratdatabasetools
doc: "The provided text does not contain help information for the tool, but appears
  to be a system error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container image due to lack of disk space.\n\nTool homepage:
  https://github.com/TCLamnidis/EigenStratDatabaseTools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/eigenstratdatabasetools:1.1.0--hdfd78af_0
stdout: eigenstratdatabasetools.out
