cwlVersion: v1.2
class: CommandLineTool
baseCommand: itolapi_itol.py
label: itolapi_itol.py
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime (Apptainer/Singularity)
  failing to build an image due to insufficient disk space.\n\nTool homepage: https://github.com/albertyw/itolapi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/itolapi:4.1.6--pyhdfd78af_0
stdout: itolapi_itol.py.out
