cwlVersion: v1.2
class: CommandLineTool
baseCommand: drax
label: drax
doc: "The provided text does not contain help information for the tool 'drax'. It
  contains error logs from a container runtime (Apptainer/Singularity) indicating
  a failure to build the container due to lack of disk space.\n\nTool homepage: https://github.com/will-rowe/drax"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/drax:0.0.0--0
stdout: drax.out
