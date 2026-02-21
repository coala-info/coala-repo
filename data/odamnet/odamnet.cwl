cwlVersion: v1.2
class: CommandLineTool
baseCommand: odamnet
label: odamnet
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log from a container runtime (Apptainer/Singularity) indicating
  a failure to build the image due to insufficient disk space.\n\nTool homepage: https://pypi.org/project/ODAMNet/1.1.0/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/odamnet:1.1.0--pyhdfd78af_0
stdout: odamnet.out
