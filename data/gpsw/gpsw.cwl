cwlVersion: v1.2
class: CommandLineTool
baseCommand: gpsw
label: gpsw
doc: "The provided text does not contain help information for the tool 'gpsw'. It
  contains error logs related to a container runtime (Apptainer/Singularity) failing
  to build a SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/niekwit/gps-orfeome"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gpsw:0.9.1--pyhdfd78af_0
stdout: gpsw.out
