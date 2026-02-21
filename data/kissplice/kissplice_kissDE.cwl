cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissplice_kissDE
label: kissplice_kissDE
doc: "The provided text does not contain help information for the tool. It contains
  system error messages related to a container runtime (Apptainer/Singularity) failure
  due to insufficient disk space.\n\nTool homepage: http://kissplice.prabi.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice_kissDE.out
