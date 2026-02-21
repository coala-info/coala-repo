cwlVersion: v1.2
class: CommandLineTool
baseCommand: libarbdb
label: libarbdb
doc: "The provided text does not contain help information for libarbdb; it is an error
  log from a container runtime (Apptainer/Singularity) indicating a failure to build
  the container due to insufficient disk space.\n\nTool homepage: http://www.arb-home.de"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/libarbdb:6.0.6--2
stdout: libarbdb.out
