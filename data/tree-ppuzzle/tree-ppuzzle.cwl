cwlVersion: v1.2
class: CommandLineTool
baseCommand: tree-ppuzzle
label: tree-ppuzzle
doc: The provided text does not contain help information or usage instructions for
  the tool. It is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to lack of disk space.
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/tree-ppuzzle:v5.2-11-deb_cv1
stdout: tree-ppuzzle.out
