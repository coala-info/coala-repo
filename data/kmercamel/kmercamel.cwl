cwlVersion: v1.2
class: CommandLineTool
baseCommand: kmercamel
label: kmercamel
doc: "The provided text does not contain help information for kmercamel; it is an
  error log from a container runtime (Apptainer/Singularity) indicating a failure
  to build the container due to lack of disk space.\n\nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel.out
