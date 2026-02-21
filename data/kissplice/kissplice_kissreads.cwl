cwlVersion: v1.2
class: CommandLineTool
baseCommand: kissreads
label: kissplice_kissreads
doc: "The provided text does not contain help information for the tool, but rather
  an error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the image due to lack of disk space.\n\nTool homepage: http://kissplice.prabi.fr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kissplice:2.6.5--h077b44d_1
stdout: kissplice_kissreads.out
